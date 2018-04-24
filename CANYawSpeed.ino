//CANYawSpeed

#include "quaternionFilters.h"
#include "MPU9250.h"

#include <mcp_can.h>
#include <SPI.h>
#include <Timer.h>
#include "VCAN_SRR3T_Tram.h"
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
unsigned VehicleSpeed_UB = 0;
unsigned YawRate_QF = 0;
unsigned YawRate_UB = 0;
unsigned SRR3T_MsgCounter_TrackerMain = 0;
unsigned SRR3T_CRC_TrackerMain = 0;

//TrackerAdditional
unsigned LateralAcceleration = 0;
unsigned LongitudinalAcceleration = 0;
float EffectiveWheelBase = 1.435;
unsigned SteeringWheelAngle = 0;
unsigned EPBStatus = 0;
unsigned TrailerConnection = 0;
unsigned SRR3T_MsgCounter_TrackAdditional = 0;
unsigned SRR3T_CRC_TrackerAdditional = 0;

unsigned StateMachineCtrl = 0;

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

  //delay(1000);

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

  t.every(20, send20msMSGs);
  t.every(50, send50msMSGs);
  t.every(200, send200msMSGs);


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
    myIMU.readAccelData(myIMU.accelCount);  // Read the x/y/z adc values
    myIMU.getAres();

    // Now we'll calculate the accleration value into actual g's
    // This depends on scale being set
    myIMU.ax = (float)myIMU.accelCount[0]*myIMU.aRes; // - accelBias[0];
    myIMU.ay = (float)myIMU.accelCount[1]*myIMU.aRes; // - accelBias[1];
    myIMU.az = (float)myIMU.accelCount[2]*myIMU.aRes; // - accelBias[2];

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

  // Sensors x (y)-axis of the accelerometer is aligned with the y (x)-axis of
  // the magnetometer; the magnetometer z-axis (+ down) is opposite to z-axis
  // (+ up) of accelerometer and gyro! We have to make some allowance for this
  // orientationmismatch in feeding the output to the quaternion filter. For the
  // MPU-9250, we have chosen a magnetic rotation that keeps the sensor forward
  // along the x-axis just like in the LSM9DS0 sensor. This rotation can be
  // modified to allow any convenient orientation convention. This is ok by
  // aircraft orientation standards! Pass gyro rate as rad/s
//  MadgwickQuaternionUpdate(ax, ay, az, gx*PI/180.0f, gy*PI/180.0f, gz*PI/180.0f,  my,  mx, mz);
  MahonyQuaternionUpdate(myIMU.ax, myIMU.ay, myIMU.az, myIMU.gx*DEG_TO_RAD,
                         myIMU.gy*DEG_TO_RAD, myIMU.gz*DEG_TO_RAD, myIMU.my,
                         myIMU.mx, myIMU.mz, myIMU.deltat);

  if (!AHRS)
  {
    myIMU.delt_t = millis() - myIMU.count;
    if (myIMU.delt_t > 500)
    {
      if(SerialDebug)
      {

        // Print gyro values in degree/sec
        /*
        Serial.print("X-gyro rate: "); Serial.print(myIMU.gx, 3);
        Serial.print(" degrees/sec ");
        Serial.print("Y-gyro rate: "); Serial.print(myIMU.gy, 3);
        Serial.print(" degrees/sec ");
        Serial.print("Z-gyro rate: "); Serial.print(myIMU.gz, 3);
        Serial.println(" degrees/sec");
        */

      }

      myIMU.count = millis();
      digitalWrite(myLed, !digitalRead(myLed));  // toggle led
    } // if (myIMU.delt_t > 500)
  } // if (!AHRS)
  else
  {
    // Serial print and/or display at 0.5 s rate independent of data rates
    myIMU.delt_t = millis() - myIMU.count;

    // update LCD once per half-second independent of read rate
    if (myIMU.delt_t > 500)
    {
      if(SerialDebug)
      {
        /*
        //Serial.print("gx = "); Serial.print( myIMU.gx, 2);
        //Serial.print(" gy = "); Serial.print( myIMU.gy, 2);
        Serial.println(" gz = "); Serial.print( myIMU.gz*PI/180, 2);
        Serial.println(" rad/s");
        */

        /*
        Serial.print("q0 = "); Serial.print(*getQ());
        Serial.print(" qx = "); Serial.print(*(getQ() + 1));
        Serial.print(" qy = "); Serial.print(*(getQ() + 2));
        Serial.print(" qz = "); Serial.println(*(getQ() + 3));
        */

      }

// Define output variables from updated quaternion---these are Tait-Bryan
// angles, commonly used in aircraft orientation. In this coordinate system,
// the positive z-axis is down toward Earth. Yaw is the angle between Sensor
// x-axis and Earth magnetic North (or true North if corrected for local
// declination, looking down on the sensor positive yaw is counterclockwise.
// Pitch is angle between sensor x-axis and Earth ground plane, toward the
// Earth is positive, up toward the sky is negative. Roll is angle between
// sensor y-axis and Earth ground plane, y-axis up is positive roll. These
// arise from the definition of the homogeneous rotation matrix constructed
// from quaternions. Tait-Bryan angles as well as Euler angles are
// non-commutative; that is, the get the correct orientation the rotations
// must be applied in the correct order which for this configuration is yaw,
// pitch, and then roll.
// For more see
// http://en.wikipedia.org/wiki/Conversion_between_quaternions_and_Euler_angles
// which has additional links.
      //myIMU.yaw   = atan2(2.0f * (*(getQ()+1) * *(getQ()+2) + *getQ() *
//                    *(getQ()+3)), *getQ() * *getQ() + *(getQ()+1) * *(getQ()+1)
//                    - *(getQ()+2) * *(getQ()+2) - *(getQ()+3) * *(getQ()+3));

      //myIMU.yaw   *= RAD_TO_DEG;
      // Declination of SparkFun Electronics (40°05'26.6"N 105°11'05.9"W) is
      //    8° 30' E  ± 0° 21' (or 8.5°) on 2016-07-19
      // - http://www.ngdc.noaa.gov/geomag-web/#declination
     // myIMU.yaw   -= 8.5;


    //myIMU.yaw = 180 * atan (myIMU.az/sqrt(myIMU.ax*myIMU.ax + myIMU.az*myIMU.az))/PI;
    myIMU.yaw = PI * myIMU.gz / 180;
    YawRate = myIMU.yaw;


      myIMU.count = millis();
      myIMU.sumCount = 0;
      myIMU.sum = 0;
    } // if (myIMU.delt_t > 500)
  } // if (AHRS)


  /*RPM loop below*/
  if (millis() - timeold >= delaytime1) {
      //Don't process interrupts during calculations
      detachInterrupt(0);
      rpm = (60 * delaytime1 / pulsesperturn )/ (millis() - timeold)* pulses;
      timeold = millis();
      pulses = 0;
      VehicleSpeed=0.06*rpm;
      attachInterrupt(0, counter, FALLING);
      Serial.println("speed: ");
      Serial.print(VehicleSpeed);
   }

// Print to monitor
         if(SerialDebug)
      {
        //delay(1000);
        Serial.println("Yaw ");
        Serial.print(myIMU.yaw, 2);

        Serial.println("");

        //Serial.println(" Speed: ");
        //Serial.print(VehicleSpeed);
      }

}


void send20msMSGs() //TrackerMain
{
  fill_SRR3T_TrackerMain(canMessage20 , VehicleSpeed, YawRate, SideSlipAngle, ReversedGear, ReversedGear_UB, VehicleSpeed_QF, VehicleSpeed_UB, YawRate_QF, YawRate_UB, SRR3T_MsgCounter_TrackerMain, SRR3T_CRC_TrackerMain);
  CAN0.sendMsgBuf(canMessage20.id, 1, canMessage20.len, canMessage20.data);
}

  void send50msMSGs()//TrackerAdditional every 50
{
  fill_SRR3T_TrackerAdditional(canMessage50 , LateralAcceleration, LongitudinalAcceleration, EffectiveWheelBase, SteeringWheelAngle, EPBStatus, TrailerConnection, SRR3T_MsgCounter_TrackAdditional, SRR3T_CRC_TrackerAdditional);
  CAN0.sendMsgBuf(canMessage50.id, 1, canMessage50.len, canMessage50.data);
}

void send200msMSGs() //stateMachine every 200ms
{
  fill_SRR3T_StateMachine(canMessage200 , StateMachineCtrl);
  CAN0.sendMsgBuf(canMessage200.id, 1, canMessage200.len, canMessage200.data);
}
