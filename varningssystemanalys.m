%function Sliderplot


% data
data = load('C:\Users\BetinaA\Documents\Spårvagnsprojektet\LoggarTram\VOLVO_SRR3_11_TRAM_4_20180509_GS_BA_TEST_APTIV_TRAM_014.mat');
source = load('C:\Users\BetinaA\Documents\Spårvagnsprojektet\LoggarTram\VOLVO_SRR3_11_TRAM_4_20180509_GS_BA_TEST_APTIV_TRAM_014.mat');

% length
indata.tot = length(source.dvlExt.SCANIA.VCAN.SRR3T_System_Status_R.ctime);
indata.cTime = double(source.dvlExt.SCANIA.VCAN.SRR3T_System_Status_R.ctime);

% CAN-data
can_cTime = source.dvlExt.SCANIA.VCAN.SRR3T_System_Status_R.ctime;

%MATLAB resim data
resim_available = isfield(source.dvlExt.SCANIA,'VCAN');  %if tram output in in .VCAN

    % LongPos
    indata.resim_longpos.b1 = [data.dvlExt.SCANIA.VCAN.SRR3T_B_1_R_Master.SRR3T_LongPos_B_1]';
    indata.resim_longpos.b2 = [data.dvlExt.SCANIA.VCAN.SRR3T_B_2_R_Master.SRR3T_LongPos_B_2]';
    indata.resim_longpos.b3 = [data.dvlExt.SCANIA.VCAN.SRR3T_B_3_R_Master.SRR3T_LongPos_B_3]';
    indata.resim_longpos.b4 = [data.dvlExt.SCANIA.VCAN.SRR3T_B_4_R_Master.SRR3T_LongPos_B_4]';
    indata.resim_longpos.b5 = [data.dvlExt.SCANIA.VCAN.SRR3T_B_5_R_Master.SRR3T_LongPos_B_5]';
    indata.resim_longpos.b6 = [data.dvlExt.SCANIA.VCAN.SRR3T_B_6_R_Master.SRR3T_LongPos_B_6]';
    indata.resim_longpos.b7 = [data.dvlExt.SCANIA.VCAN.SRR3T_B_7_R_Master.SRR3T_LongPos_B_7]';
    indata.resim_longpos.b8 = [data.dvlExt.SCANIA.VCAN.SRR3T_B_8_R_Master.SRR3T_LongPos_B_8]';
    indata.resim_longpos.b9 = [data.dvlExt.SCANIA.VCAN.SRR3T_B_9_R_Master.SRR3T_LongPos_B_9]';
    indata.resim_longpos.b10 = [data.dvlExt.SCANIA.VCAN.SRR3T_B_10_R_Master.SRR3T_LongPos_B_10]';

    % LatPos
    indata.resim_latpos.b1 = [data.dvlExt.SCANIA.VCAN.SRR3T_B_1_R_Master.SRR3T_LatPos_B_1]';
    indata.resim_latpos.b2 = [data.dvlExt.SCANIA.VCAN.SRR3T_B_2_R_Master.SRR3T_LatPos_B_2]';
    indata.resim_latpos.b3 = [data.dvlExt.SCANIA.VCAN.SRR3T_B_3_R_Master.SRR3T_LatPos_B_3]';
    indata.resim_latpos.b4 = [data.dvlExt.SCANIA.VCAN.SRR3T_B_4_R_Master.SRR3T_LatPos_B_4]';
    indata.resim_latpos.b5 = [data.dvlExt.SCANIA.VCAN.SRR3T_B_5_R_Master.SRR3T_LatPos_B_5]';
    indata.resim_latpos.b6 = [data.dvlExt.SCANIA.VCAN.SRR3T_B_6_R_Master.SRR3T_LatPos_B_6]';
    indata.resim_latpos.b7 = [data.dvlExt.SCANIA.VCAN.SRR3T_B_7_R_Master.SRR3T_LatPos_B_7]';
    indata.resim_latpos.b8 = [data.dvlExt.SCANIA.VCAN.SRR3T_B_8_R_Master.SRR3T_LatPos_B_8]';
    indata.resim_latpos.b9 = [data.dvlExt.SCANIA.VCAN.SRR3T_B_9_R_Master.SRR3T_LatPos_B_9]';
    indata.resim_latpos.b10 = [data.dvlExt.SCANIA.VCAN.SRR3T_B_10_R_Master.SRR3T_LatPos_B_10]';

    %LongVel
    indata.longvel.c1 = [data.dvlExt.SCANIA.VCAN.SRR3T_C_1_R_Master.SRR3T_LongVel_C_1]';
    indata.longvel.c2 = [data.dvlExt.SCANIA.VCAN.SRR3T_C_2_R_Master.SRR3T_LongVel_C_2]';
    indata.longvel.c3 = [data.dvlExt.SCANIA.VCAN.SRR3T_C_3_R_Master.SRR3T_LongVel_C_3]';
    indata.longvel.c4 = [data.dvlExt.SCANIA.VCAN.SRR3T_C_4_R_Master.SRR3T_LongVel_C_4]';
    indata.longvel.c5 = [data.dvlExt.SCANIA.VCAN.SRR3T_C_5_R_Master.SRR3T_LongVel_C_5]';
    indata.longvel.c6 = [data.dvlExt.SCANIA.VCAN.SRR3T_C_6_R_Master.SRR3T_LongVel_C_6]';
    indata.longvel.c7 = [data.dvlExt.SCANIA.VCAN.SRR3T_C_7_R_Master.SRR3T_LongVel_C_7]';
    indata.longvel.c8 = [data.dvlExt.SCANIA.VCAN.SRR3T_C_8_R_Master.SRR3T_LongVel_C_8]';
    indata.longvel.c9 = [data.dvlExt.SCANIA.VCAN.SRR3T_C_9_R_Master.SRR3T_LongVel_C_9]';
    indata.longvel.c10 = [data.dvlExt.SCANIA.VCAN.SRR3T_C_10_R_Master.SRR3T_LongVel_C_10]';

    %LatVel
    indata.latvel.c1 = [data.dvlExt.SCANIA.VCAN.SRR3T_C_1_R_Master.SRR3T_LatVel_C_1]';
    indata.latvel.c2 = [data.dvlExt.SCANIA.VCAN.SRR3T_C_2_R_Master.SRR3T_LatVel_C_2]';
    indata.latvel.c3 = [data.dvlExt.SCANIA.VCAN.SRR3T_C_3_R_Master.SRR3T_LatVel_C_3]';
    indata.latvel.c4 = [data.dvlExt.SCANIA.VCAN.SRR3T_C_4_R_Master.SRR3T_LatVel_C_4]';
    indata.latvel.c5 = [data.dvlExt.SCANIA.VCAN.SRR3T_C_5_R_Master.SRR3T_LatVel_C_5]';
    indata.latvel.c6 = [data.dvlExt.SCANIA.VCAN.SRR3T_C_6_R_Master.SRR3T_LatVel_C_6]';
    indata.latvel.c7 = [data.dvlExt.SCANIA.VCAN.SRR3T_C_7_R_Master.SRR3T_LatVel_C_7]';
    indata.latvel.c8 = [data.dvlExt.SCANIA.VCAN.SRR3T_C_8_R_Master.SRR3T_LatVel_C_8]';
    indata.latvel.c9 = [data.dvlExt.SCANIA.VCAN.SRR3T_C_9_R_Master.SRR3T_LatVel_C_9]';
    indata.latvel.c10 = [data.dvlExt.SCANIA.VCAN.SRR3T_C_10_R_Master.SRR3T_LatVel_C_10]';

    % Tram Speed & yaw
    indata.tramSpeed = [data.dvlExt.SCANIA.VCAN.SRR3T_TrackerMain.VehicleSpeed]';
    indata.yaw = [data.dvlExt.SCANIA.VCAN.SRR3T_TrackerMain.YawRate]';
    
    % Width
    indata.width.b1 = [data.dvlExt.SCANIA.VCAN.SRR3T_B_1_R_Master.SRR3T_Width_B_1]';
    
    % Length
    indata.length.b1 = [data.dvlExt.SCANIA.VCAN.SRR3T_B_1_R_Master.SRR3T_Length_B_1]';
    
    % FreeSpace
    indata.fs(1).fs = [data.dvlExt.SCANIA.VCAN.FS_R01.FS_distance_out_R01];
    indata.fs(2).fs = [data.dvlExt.SCANIA.VCAN.FS_R02.FS_distance_out_R02];
    indata.fs(3).fs = [data.dvlExt.SCANIA.VCAN.FS_R03.FS_distance_out_R03];
    indata.fs(4).fs = [data.dvlExt.SCANIA.VCAN.FS_R04.FS_distance_out_R04];
    indata.fs(5).fs = [data.dvlExt.SCANIA.VCAN.FS_R05.FS_distance_out_R05];
    indata.fs(6).fs = [data.dvlExt.SCANIA.VCAN.FS_R06.FS_distance_out_R06];
    indata.fs(7).fs = [data.dvlExt.SCANIA.VCAN.FS_R07.FS_distance_out_R07];
    indata.fs(8).fs = [data.dvlExt.SCANIA.VCAN.FS_R08.FS_distance_out_R08];
    indata.fs(9).fs = [data.dvlExt.SCANIA.VCAN.FS_R09.FS_distance_out_R09];
    indata.fs(10).fs = [data.dvlExt.SCANIA.VCAN.FS_R10.FS_distance_out_R10];
    indata.fs(11).fs = [data.dvlExt.SCANIA.VCAN.FS_R11.FS_distance_out_R11];
    indata.fs(12).fs = [data.dvlExt.SCANIA.VCAN.FS_R12.FS_distance_out_R12];
    indata.fs(13).fs = [data.dvlExt.SCANIA.VCAN.FS_R13.FS_distance_out_R13];
    indata.fs(14).fs = [data.dvlExt.SCANIA.VCAN.FS_R14.FS_distance_out_R14];
    indata.fs(15).fs = [data.dvlExt.SCANIA.VCAN.FS_R15.FS_distance_out_R15];
    indata.fs(16).fs = [data.dvlExt.SCANIA.VCAN.FS_R16.FS_distance_out_R16];
    indata.fs(17).fs = [data.dvlExt.SCANIA.VCAN.FS_R17.FS_distance_out_R17];
    indata.fs(18).fs = [data.dvlExt.SCANIA.VCAN.FS_R18.FS_distance_out_R18];
    indata.fs(19).fs = [data.dvlExt.SCANIA.VCAN.FS_R19.FS_distance_out_R19];
    indata.fs(20).fs = [data.dvlExt.SCANIA.VCAN.FS_R20.FS_distance_out_R20];
    indata.fs(21).fs = [data.dvlExt.SCANIA.VCAN.FS_R21.FS_distance_out_R21];
    indata.fs(22).fs = [data.dvlExt.SCANIA.VCAN.FS_R22.FS_distance_out_R22];
    indata.fs(23).fs = [data.dvlExt.SCANIA.VCAN.FS_R23.FS_distance_out_R23];
    indata.fs(24).fs = [data.dvlExt.SCANIA.VCAN.FS_R24.FS_distance_out_R24];
    indata.fs(25).fs = [data.dvlExt.SCANIA.VCAN.FS_R25.FS_distance_out_R25];
    indata.fs(26).fs = [data.dvlExt.SCANIA.VCAN.FS_R26.FS_distance_out_R26];
    indata.fs(27).fs = [data.dvlExt.SCANIA.VCAN.FS_R27.FS_distance_out_R27];
    indata.fs(28).fs = [data.dvlExt.SCANIA.VCAN.FS_R28.FS_distance_out_R28];
    indata.fs(29).fs = [data.dvlExt.SCANIA.VCAN.FS_R29.FS_distance_out_R29];
    indata.fs(30).fs = [data.dvlExt.SCANIA.VCAN.FS_R30.FS_distance_out_R30];
    indata.fs(31).fs = [data.dvlExt.SCANIA.VCAN.FS_R31.FS_distance_out_R31];
    indata.fs(32).fs = [data.dvlExt.SCANIA.VCAN.FS_R32.FS_distance_out_R32];
    indata.fs(33).fs = [data.dvlExt.SCANIA.VCAN.FS_R33.FS_distance_out_R33];
    indata.fs(34).fs = [data.dvlExt.SCANIA.VCAN.FS_R34.FS_distance_out_R34];
    indata.fs(35).fs = [data.dvlExt.SCANIA.VCAN.FS_R35.FS_distance_out_R35];
    indata.fs(36).fs = [data.dvlExt.SCANIA.VCAN.FS_R36.FS_distance_out_R36];
    indata.fs(37).fs = [data.dvlExt.SCANIA.VCAN.FS_R37.FS_distance_out_R37];
    indata.fs(38).fs = [data.dvlExt.SCANIA.VCAN.FS_R38.FS_distance_out_R38];
    indata.fs(39).fs = [data.dvlExt.SCANIA.VCAN.FS_R39.FS_distance_out_R39];
    indata.fs(40).fs = [data.dvlExt.SCANIA.VCAN.FS_R40.FS_distance_out_R40];
    indata.fs(41).fs = [data.dvlExt.SCANIA.VCAN.FS_R41.FS_distance_out_R41];
    indata.fs(42).fs = [data.dvlExt.SCANIA.VCAN.FS_R42.FS_distance_out_R42];
    indata.fs(43).fs = [data.dvlExt.SCANIA.VCAN.FS_R43.FS_distance_out_R43];
    indata.fs(44).fs = [data.dvlExt.SCANIA.VCAN.FS_R44.FS_distance_out_R44];
    indata.fs(45).fs = [data.dvlExt.SCANIA.VCAN.FS_R45.FS_distance_out_R45];
    indata.fs(46).fs = [data.dvlExt.SCANIA.VCAN.FS_R46.FS_distance_out_R46];
    indata.fs(47).fs = [data.dvlExt.SCANIA.VCAN.FS_R47.FS_distance_out_R47];
    indata.fs(48).fs = [data.dvlExt.SCANIA.VCAN.FS_R48.FS_distance_out_R48];
    indata.fs(49).fs = [data.dvlExt.SCANIA.VCAN.FS_R49.FS_distance_out_R49];
    indata.fs(50).fs = [data.dvlExt.SCANIA.VCAN.FS_R50.FS_distance_out_R50];
    indata.fs(51).fs = [data.dvlExt.SCANIA.VCAN.FS_R51.FS_distance_out_R51];
    indata.fs(52).fs = [data.dvlExt.SCANIA.VCAN.FS_R52.FS_distance_out_R52];
    indata.fs(53).fs = [data.dvlExt.SCANIA.VCAN.FS_R53.FS_distance_out_R53];
    indata.fs(54).fs = [data.dvlExt.SCANIA.VCAN.FS_R54.FS_distance_out_R54];
    indata.fs(55).fs = [data.dvlExt.SCANIA.VCAN.FS_R55.FS_distance_out_R55];
    indata.fs(56).fs = [data.dvlExt.SCANIA.VCAN.FS_R56.FS_distance_out_R56];
    indata.fs(57).fs = [data.dvlExt.SCANIA.VCAN.FS_R57.FS_distance_out_R57];
    indata.fs(58).fs = [data.dvlExt.SCANIA.VCAN.FS_R58.FS_distance_out_R58];
    indata.fs(59).fs = [data.dvlExt.SCANIA.VCAN.FS_R59.FS_distance_out_R59];
    indata.fs(60).fs = [data.dvlExt.SCANIA.VCAN.FS_R60.FS_distance_out_R60];
    
    ix = length(indata.fs(1).fs);
    if ix > length(indata.fs(60).fs)
        ix = length(indata.fs(60).fs);
    end
    %checks if all contains same amount of samples
    for i=1:60
        if(length(indata.fs(i).fs)>ix) %deletes first row up, depending on dif value
            dif=length(indata.fs(i).fs)-ix;
            indata.fs(i).fs(1:dif,:)=[]; 
        end
    end


    

%Create plots
figure
plots.predicted_path_left = plot(0,0,'r', 'LineWidth', 2);
hold on

% make objects appear as squares
plots.dangerous_object1 = plot(0,0, 'ks','MarkerSize',10);
plots.dangerous_object2 = plot(0,0, 'rs','MarkerSize',10);
plots.dangerous_object3 = plot(0,0, 'ms','MarkerSize',10);
plots.dangerous_object4 = plot(0,0, 'bs','MarkerSize',10);
plots.dangerous_object5 = plot(0,0, 'gs','MarkerSize',10);
plots.dangerous_object6 = plot(0,0, 'ks','MarkerSize',10);
plots.dangerous_object7 = plot(0,0, 'cs','MarkerSize',10);
plots.dangerous_object8 = plot(0,0, 'ms','MarkerSize',10);
plots.dangerous_object9 = plot(0,0, 'rs','MarkerSize',10);
plots.dangerous_object10 = plot(0,0, 'ko','MarkerSize',10);


% freespace
for k= 1:60
    plots.FS(k) = plot(0,0,'g*');
end
%FREESPACE
FS = [indata.fs(1).fs, indata.fs(2).fs, indata.fs(3).fs, indata.fs(4).fs, indata.fs(5).fs, indata.fs(6).fs, indata.fs(7).fs, indata.fs(8).fs, indata.fs(9).fs, indata.fs(10).fs, indata.fs(11).fs, indata.fs(12).fs, indata.fs(13).fs, indata.fs(14).fs, indata.fs(15).fs, indata.fs(16).fs, indata.fs(17).fs, indata.fs(18).fs, indata.fs(19).fs, indata.fs(20).fs, indata.fs(21).fs, indata.fs(22).fs, indata.fs(23).fs, indata.fs(24).fs, indata.fs(25).fs, indata.fs(26).fs, indata.fs(27).fs, indata.fs(28).fs, indata.fs(29).fs, indata.fs(30).fs, indata.fs(31).fs, indata.fs(32).fs, indata.fs(33).fs, indata.fs(34).fs, indata.fs(35).fs, indata.fs(36).fs, indata.fs(37).fs, indata.fs(38).fs, indata.fs(39).fs, indata.fs(40).fs, indata.fs(41).fs, indata.fs(42).fs, indata.fs(43).fs, indata.fs(44).fs, indata.fs(45).fs, indata.fs(46).fs, indata.fs(47).fs, indata.fs(48).fs, indata.fs(49).fs, indata.fs(50).fs, indata.fs(51).fs, indata.fs(52).fs, indata.fs(53).fs, indata.fs(54).fs, indata.fs(55).fs, indata.fs(56).fs, indata.fs(57).fs, indata.fs(58).fs, indata.fs(59).fs, indata.fs(60).fs];

% tram
latsize_tram1=[-1.3,-1.3, 1.3, 1.3, -1.3]; %x position: left upper corner, left lower, right lower, upper right, left upper again to close the square
longsize_tram1=[0, -9, -9, 0, 0]; %y position: left upper corner, left lower, right lower, upper right, left upper again to close the square
plots.tram1=plot(latsize_tram1,longsize_tram1, 'b-', 'Linewidth', 3);

grid on
xlabel('Latitude (m)');
ylabel('Longitude (m)');
axis([-20 20 -9 30])

%Create slider with listener
h = uicontrol('style','slider','Min',1,'Max',indata.tot,'Value',1,'SliderStep',[1/indata.tot 1/indata.tot],'units','pixel','position',[20 20 300 20]);
% plot 
addlistener(h,'ContinuousValueChange',@(hObject, event) makeplot(hObject,indata,plots));
%lamp
u=uicontrol('style','edit','String',' ','BackgroundColor',[1 1 1], 'position',[525 250 20 20]);
% warn
addlistener(h,'ContinuousValueChange',@(hObject, event) fcws4(hObject,indata.tramSpeed, indata.resim_latpos.b1, indata.latvel.c1, indata.resim_longpos.b1, indata.longvel.c1, indata.width.b1, FS, u, indata.yaw));
%end


function makeplot(hObject,indata,plots)
new_refidx = round(get(hObject,'Value'));

set(hObject,'Value',new_refidx);

%Update plots with objects

set(plots.dangerous_object1, 'xdata', -indata.resim_latpos.b1(new_refidx))
set(plots.dangerous_object1, 'ydata', indata.resim_longpos.b1(new_refidx))
set(plots.dangerous_object2, 'xdata', -indata.resim_latpos.b2(new_refidx))
set(plots.dangerous_object2, 'ydata', indata.resim_longpos.b2(new_refidx))
set(plots.dangerous_object3, 'xdata', -indata.resim_latpos.b3(new_refidx))
set(plots.dangerous_object3, 'ydata', indata.resim_longpos.b3(new_refidx))
set(plots.dangerous_object4, 'xdata', -indata.resim_latpos.b4(new_refidx))
set(plots.dangerous_object4, 'ydata', indata.resim_longpos.b4(new_refidx))
set(plots.dangerous_object5, 'xdata', -indata.resim_latpos.b5(new_refidx))
set(plots.dangerous_object5, 'ydata', indata.resim_longpos.b5(new_refidx))
set(plots.dangerous_object6, 'xdata', -indata.resim_latpos.b6(new_refidx))
set(plots.dangerous_object6, 'ydata', indata.resim_longpos.b6(new_refidx))
set(plots.dangerous_object7, 'xdata', -indata.resim_latpos.b7(new_refidx))
set(plots.dangerous_object7, 'ydata', indata.resim_longpos.b7(new_refidx))
set(plots.dangerous_object8, 'xdata', -indata.resim_latpos.b8(new_refidx))
set(plots.dangerous_object8, 'ydata', indata.resim_longpos.b8(new_refidx))
set(plots.dangerous_object9, 'xdata', -indata.resim_latpos.b9(new_refidx))
set(plots.dangerous_object9, 'ydata', indata.resim_longpos.b9(new_refidx))
set(plots.dangerous_object10, 'xdata', -indata.resim_latpos.b10(new_refidx))
set(plots.dangerous_object10, 'ydata', indata.resim_longpos.b10(new_refidx))

%FREESPACE
%freespace plotting all
for k = 1:60
    if k < 31
        set(plots.FS(k), 'xdata', indata.fs(k).fs(new_refidx)*cos((k*3)*(pi/180)))
        set(plots.FS(k), 'ydata', indata.fs(k).fs(new_refidx)*sin((k*3)*(pi/180)))
    else
        set(plots.FS(k), 'xdata', indata.fs(k).fs(new_refidx)*-sin((k*3-90)*(pi/180)))
        set(plots.FS(k), 'ydata', indata.fs(k).fs(new_refidx)*cos((k*3-90)*(pi/180)))
    end
end

%Show samplenumber
title(strcat('Sample number: ',num2str(new_refidx)));
%show tram speed and yaw
uicontrol('style','edit','String', indata.tramSpeed(ceil(new_refidx*2.15)), 'position',[520 200 30 30]);
uicontrol('style','edit','String', indata.yaw(ceil(new_refidx*2.15)), 'position',[520 150 30 30]);


end

% algorithm form https://www.hindawi.com/journals/cin/2014/761047/
function fcws4(hObject, tramSpeed, latpos, latvel, longpos, longvel, width, FS, u, yaw)
new_refidx = round(get(hObject,'Value'));   % sample id 
set(hObject,'Value',new_refidx);

xtramSpeed = tramSpeed(ceil(new_refidx*2.15))/3.6;
xlatpos = -latpos(new_refidx);
xlatvel = latvel(new_refidx);
xlongpos = longpos(new_refidx);
xlongvel = longvel(new_refidx);
xwidth = width(new_refidx);
xyaw = yaw(ceil(new_refidx*2.15));

% a = 2ds/dt^2
ax = (2*(latpos(new_refidx)-latpos(new_refidx-1))/0.05);
ay = (2*(longpos(new_refidx)-longpos(new_refidx-1))/0.05);
aty = 0;

% Loop through each freespace sample
for k = 1 : 60
    if FS(new_refidx, k) == 300 || FS(new_refidx, k) > 50
    elseif k < 31
        lightLamp(simpleTTC(xtramSpeed, (FS(new_refidx, k)*sin((k*3)*(pi/180))), 0, (FS(new_refidx, k)*cos((k*3)*(pi/180))), 0.2, xyaw), u, new_refidx);
    else
        lightLamp(simpleTTC(xtramSpeed, (FS(new_refidx, k)*cos((k*3-90)*(pi/180))), 0, (FS(new_refidx, k)*-sin((k*3-90)*(pi/180))), 0.2, xyaw), u, new_refidx);
    end
end

%analyze objects
lightLamp(fcwsCircle(xtramSpeed, xlatpos, xlatvel, xlongpos, xlongvel, xwidth, ax, ay, aty, u, new_refidx, xyaw), u, new_refidx);

end

function [val] = fcwsCircle(tramSpeed, latpos, latvel, longpos, longvel, width, ax, ay, aty, u, index, yaw)
r1 = width*1.3; % fordonets buffer-radie
r2 = 1.5;   % spårvagnens buffer-radie
val = 0;

    if (longvel > tramSpeed)    %if object drives faster than the tram, then no need to investigate it
    elseif (latpos >= -5 && -latpos <5 && latpos ~=0)   % only investigate if object is within 5m from the sides
            syms TTCij
            
            %source: https://www.hindawi.com/journals/cin/2014/761047/#EEq1
            A = (r1+r2)^2;
            G = 0.5*(ax + ay + aty);
            eqn = G*TTCij^2 + TTCij*(latvel - tramSpeed) == (sqrt(A)-(latpos + longpos)); 

            TTCx = solve(eqn, TTCij);
            TTC = min(double(TTCx));

            % if the bigger circles collide, there is a possibility of a
            % real collision
            if TTC <= 3
                lightLamp(simpleTTC(tramSpeed, longpos, longvel, latpos, width, yaw), u, index);
            end
    
    % if there is no collision when analyzing the vehicles with their
    % buffer area, then there is no collision
    else
        val = 0;

    end

end


function [val] = simpleTTC(tramSpeed, longpos, longvel, latpos, width, yaw)
val = 0;

dwl = -1.3 - width;  % danger width left
dwr = 1.3 + width;  % danger width right

if yaw > 0  %svänger höger
    dwr = dwr - yaw;    %mindre av höger sida analyseras
elseif yaw < 0
    dwl = dwl - yaw;
end
    
% analyze TTC:
    if(latpos <dwl || latpos >dwr || latpos == 0)  % decide which latitudinal distance is relevant
            % do nothing
    else
        % source: http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.511.3548&rep=rep1&type=pdf
        TTCbr = ((tramSpeed)/(2*1.4));  % Tid för bromssträckan
        TTCmin = longpos / (tramSpeed - longvel);   %Tid till kollisionen
        TTC = TTCbr + TTCmin;
        
        
        %decide warning level
        if TTC <= 1 
            disp("TTC: " + TTC)
            val = 1;

        elseif TTC <= 2
            disp("TTC: " + TTC)
            val = 2;

        elseif TTC <= 3
            disp("TTC: " + TTC)
            val = 3;

        else
            val = 0;
        end

    end


end


function lightLamp(lampValue, u, index)
global x;
lamp = get(u, 'BackgroundColor');
red = [1 0 0];
yellow = [1 1 0];
blue = [0 0 1];
white = [1 1 1];



% prioritixe the warnings
if(index == x)
    if lampValue == 0 && (~isequal(lamp,white))
        lampValue = 4;
    elseif (lampValue == 3 && ~isequal(lamp,blue)) || (lampValue == 2 && ~isequal(lamp,yellow))
        %change to blue or yellow
    elseif lampValue == 2 || lampValue == 3 && (isequal(lamp,red))
        lampValue = 1;
    elseif lampValue == 3 && (isequal(lamp,yellow))
        lampValue = 2;
    end
else
    x = index;
end

%ligh up the lamps
if lampValue == 1
    if(~isequal(lamp,red)) %if lamp aint red
        set(u, 'BackgroundColor', red)
    end
elseif lampValue == 2
    if (~isequal(lamp,yellow)) %if lamp aint yellow
        set(u, 'BackgroundColor', yellow)
    end
elseif lampValue == 3
    if(~isequal(lamp,blue)) %if lamp aint blue
        set(u, 'BackgroundColor', blue)
    end
elseif lampValue == 0
    if(~isequal(lamp,white)) %if lamp aint white
        set(u, 'BackgroundColor', white)
    end
end


end