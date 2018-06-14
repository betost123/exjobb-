//CANYawSpeed

#include "quaternionFilters.h"
#include "MPU9250.h"

#include <mcp_can.h>
#include <SPI.h>
#include <Timer.h>
#include "VCAN_RADAR_Tram.h" //edit radar
#include <Wire.h>
#include <TimerOne.h>

#define AHRS true         // Set to false for basic data read
#define SerialDebug true  // Set to true to get Serial output for debugging

// Pin definitions
int intPin = 12;  // These can be changed, 2 and 3 are the Arduinos ext int pins
int myLed  = 13;  // Set up pin 13 led for toggling

MPU9250 myIMU;

/*Wheel speed initializations below*/
double tramspeed;
int delaytime1=20;
int encoder_pin = 2; // pulse output from the module
unsigned int rpm; // rpm reading
volatile byte pulses; // number of pulses
unsigned long timeold;

// number of pulses per revolution
// based on your encoder disc
unsigned int pulsesperturn = 20;
void counter()
{
   pulses++; //Update count
}

// This function read Nbytes bytes from I2C device at address Address.
// Put read bytes starting at register Register in the Data array.
void I2Cread(uint8_t Address, uint8_t Register, uint8_t Nbytes, uint8_t* Data)
{

// Set register address
Wire.beginTransmission(Address);
Wire.write(Register);
Wire.endTransmission();

// Read Nbytes
Wire.requestFrom(Address, Nbytes);
uint8_t index=0;
while (Wire.available())
Data[index++]=Wire.read();
}

// Write a byte (Data) in device (Address) at register (Register)
void I2CwriteByte(uint8_t Address, uint8_t Register, uint8_t Data)
{
// Set register address
Wire.beginTransmission(Address);
Wire.write(Register);
Wire.write(Data);
Wire.endTransmission();
}

long int ti; // Initial time
volatile bool intFlag=false;
unsigned long rxId;
byte len;
byte rxBuf[8];
float q[4] = {1.0f, 0.0f, 0.0f, 0.0f};    // vector to hold quaternion


//Sensor input
float VehicleSpeed = 0;
float YawRate; // = 0;
float SideSlipAngle = 0;
unsigned ReversedGear = 0;
unsigned ReversedGear_UB = 0;
unsigned VehicleSpeed_QF = 0;
unsigned VehicleSpeed_UB = 1;
unsigned YawRate_QF = 0;
unsigned YawRate_UB = 1;
unsigned RADAR_MsgCounter_TM = 0;   //edit radar & msg
unsigned RADAR_CRC_TM = 0;          //edit radar & msg

  int wheelCircum = 0.06;

Timer t;
vs_CANmessage canMessage20;
vs_CANmessage canMessage50;
vs_CANmessage canMessage200;

MCP_CAN CAN0(10);                              // CAN0 interface usins CS on digital pin 10
MCP_CAN CAN1(9);                               // CAN1 interface using CS on digital pin 9

void setup()
{
  Wire.begin();
  // TWBR = 12;  // 400 kbit/sec I2C speed
  Serial.begin(38400);

  // Set up the interrupt pin, its set as active high, push-pull
  pinMode(intPin, INPUT);
  digitalWrite(intPin, LOW);
  pinMode(myLed, OUTPUT);
  digitalWrite(myLed, HIGH);

  //Speed
  pulses = 0;
  rpm = 0;
  timeold = 0;

  pinMode(13, OUTPUT);
  Timer1.initialize(10000); // initialize timer1, and set a 1/2 second period
  Timer1.attachInterrupt(callback); // attaches callback() as a timer overflow interrupt
  ti=millis(); // Store initial time

  //CAN communication
  if (CAN0.begin(MCP_ANY, CAN_500KBPS, MCP_8MHZ) == CAN_OK) {
    Serial.print("CAN0: Init OK!\r\n");
    CAN0.setMode(MCP_NORMAL);
  } else Serial.print("CAN0: Init Fail!!!\r\n");

  SPI.setClockDivider(SPI_CLOCK_DIV2);         // Set SPI to run at 8MHz (16MHz / 2 = 8 MHz)

  //Read speed and yaw every 20
  t.every(19, readYaw);
  t.every(19, readSpeed);

  //send to CAN
  t.every(20, send20msMSGs);
  t.every(50, send50msMSGs);
  t.every(200, send200msMSGs);

  //print values for debugging purpose
  //t.every(100, printValues);


}
long int cpt=0; // Counter
void callback()
{
  intFlag=true;
  digitalWrite(13, digitalRead(13) ^ 1);
}


void loop()
{

  //delay(1000);

  t.update();
   while (!intFlag);
  intFlag=false;
  // Display time, SYNC WITH CAN TIME?
  delay(delaytime1);


  // If intPin goes high, all data registers have new data
  // On interrupt, check if data ready interrupt
  if (myIMU.readByte(MPU9250_ADDRESS, INT_STATUS) & 0x01)
  {

    myIMU.readGyroData(myIMU.gyroCount);  // Read the x/y/z adc values
    myIMU.getGres();

    // Calculate the gyro value into actual degrees per second
    // This depends on scale being set
    myIMU.gx = (float)myIMU.gyroCount[0]*myIMU.gRes;
    myIMU.gy = (float)myIMU.gyroCount[1]*myIMU.gRes;
    myIMU.gz = (float)myIMU.gyroCount[2]*myIMU.gRes;
  }


  // Must be called before updating quaternions!
  myIMU.updateTime();

  //update
    MahonyQuaternionUpdate(myIMU.ax, myIMU.ay, myIMU.az, myIMU.gx*DEG_TO_RAD,
                         myIMU.gy*DEG_TO_RAD, myIMU.gz*DEG_TO_RAD, myIMU.my,
                         myIMU.mx, myIMU.mz, myIMU.deltat);

}//end of loop

void readSpeed() { //[m/s]
  if (millis() - timeold >= delaytime1) {
      //Don't process interrupts during calculations
      detachInterrupt(0);
      rpm = (60 * delaytime1 / pulsesperturn )/ (millis() - timeold)* pulses;
      timeold = millis();
      pulses = 0;
      //VehicleSpeed=0.113*rpm;
      VehicleSpeed = ((0.135*rpm * 15.165)/10)*3.6;
  
      attachInterrupt(0, counter, FALLING);

   }
}

void readYaw() {
  myIMU.yaw = PI * myIMU.gz / 180;
  YawRate = myIMU.yaw;
}

void printValues() {
  Serial.println("Yaw: ");
  Serial.print(YawRate);
  Serial.println("");
  Serial.println("Speed: ");
  Serial.print(VehicleSpeed);
}

//Edit radar and message 

void send20msMSGs() //TM
{
  fill_RADAR_TM(canMessage20 , VehicleSpeed, YawRate, SideSlipAngle, ReversedGear, ReversedGear_UB, VehicleSpeed_QF, VehicleSpeed_UB, YawRate_QF, YawRate_UB, SRR3T_MsgCounter_TrackerMain, SRR3T_CRC_TrackerMain);
  CAN0.sendMsgBuf(canMessage20.id, 1, canMessage20.len, canMessage20.data);
}

  void send50msMSGs()//TA every 50
{
  fill_RADAR_TA(canMessage50 , 0, 0, 1.435, 0, 0, 0, 0, 0);
  CAN0.sendMsgBuf(canMessage50.id, 1, canMessage50.len, canMessage50.data);
}

void send200msMSGs() //SM every 200ms
{
  fill_RADAR_SM(canMessage200 , 0);
  CAN0.sendMsgBuf(canMessage200.id, 1, canMessage200.len, canMessage200.data);
}
