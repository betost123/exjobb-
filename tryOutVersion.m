%function Sliderplot


% data
data = read_scania_data('C:\Users\BetinaA\Documents\Spårvagnsprojektet\Lastbilsloggar 180223\VOLVO_SRR3_MINAKO_20180223_VGTT_AA_MM_FWD_SRR3_REFERENCE_001.dvl');
source = read_scania_data('C:\Users\BetinaA\Documents\Spårvagnsprojektet\Lastbilsloggar 180223\VOLVO_SRR3_MINAKO_20180223_VGTT_AA_MM_FWD_SRR3_REFERENCE_001.dvl');

% length
indata.tot = length(source.dvlExt.SCANIA.VCAN.SRR3T_C_5_R_Master.ctime);
indata.cTime = double(source.dvlExt.SCANIA.VCAN.SRR3T_C_5_R_Master.ctime);

% CAN-data
can_cTime = source.dvlExt.SCANIA.VCAN.SRR3T_C_5_R_Master.ctime;

%MATLAB resim data
resim_available = isfield(source.dvlExt.SCANIA,'VCAN');  %if tram output in in .VCAN
if resim_available

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

    % Headingyu
    indata.resim_heading.c1 = [data.dvlExt.SCANIA.VCAN.SRR3T_C_1_R_Master.SRR3T_HeadingAngle_C_1]';
    indata.resim_heading.c2 = [data.dvlExt.SCANIA.VCAN.SRR3T_C_2_R_Master.SRR3T_HeadingAngle_C_2]';
    indata.resim_heading.c3 = [data.dvlExt.SCANIA.VCAN.SRR3T_C_3_R_Master.SRR3T_HeadingAngle_C_3]';
    indata.resim_heading.c4 = [data.dvlExt.SCANIA.VCAN.SRR3T_C_4_R_Master.SRR3T_HeadingAngle_C_4]';
    indata.resim_heading.c5 = [data.dvlExt.SCANIA.VCAN.SRR3T_C_5_R_Master.SRR3T_HeadingAngle_C_5]';
    indata.resim_heading.c6 = [data.dvlExt.SCANIA.VCAN.SRR3T_C_6_R_Master.SRR3T_HeadingAngle_C_6]';
    indata.resim_heading.c7 = [data.dvlExt.SCANIA.VCAN.SRR3T_C_7_R_Master.SRR3T_HeadingAngle_C_7]';
    indata.resim_heading.c8 = [data.dvlExt.SCANIA.VCAN.SRR3T_C_8_R_Master.SRR3T_HeadingAngle_C_8]';
    indata.resim_heading.c9 = [data.dvlExt.SCANIA.VCAN.SRR3T_C_9_R_Master.SRR3T_HeadingAngle_C_9]';
    indata.resim_heading.c10 = [data.dvlExt.SCANIA.VCAN.SRR3T_C_10_R_Master.SRR3T_HeadingAngle_C_10]';

    

   

else

    % LongPos
    indata.resim_longpos.b1 = ones(size(indata.cTime))*NaN;  %NaN- Not a number, generates a  array of non numeric values
    indata.resim_longpos.b2 = ones(size(indata.cTime))*NaN;
    indata.resim_longpos.b3 = ones(size(indata.cTime))*NaN;
    indata.resim_longpos.b4 = ones(size(indata.cTime))*NaN;
    indata.resim_longpos.b5 = ones(size(indata.cTime))*NaN;
    indata.resim_longpos.b6 = ones(size(indata.cTime))*NaN;
    indata.resim_longpos.b7 = ones(size(indata.cTime))*NaN;
    indata.resim_longpos.b8 = ones(size(indata.cTime))*NaN;
    indata.resim_longpos.b9 = ones(size(indata.cTime))*NaN;
    indata.resim_longpos.b10 = ones(size(indata.cTime))*NaN;

    % LatPos
    indata.resim_latpos.b1 = ones(size(indata.cTime))*NaN;
    indata.resim_latpos.b2 = ones(size(indata.cTime))*NaN;
    indata.resim_latpos.b3 = ones(size(indata.cTime))*NaN;
    indata.resim_latpos.b4 = ones(size(indata.cTime))*NaN;
    indata.resim_latpos.b5 = ones(size(indata.cTime))*NaN;
    indata.resim_latpos.b6 = ones(size(indata.cTime))*NaN;
    indata.resim_latpos.b7 = ones(size(indata.cTime))*NaN;
    indata.resim_latpos.b8 = ones(size(indata.cTime))*NaN;
    indata.resim_latpos.b9 = ones(size(indata.cTime))*NaN;
    indata.resim_latpos.b10 = ones(size(indata.cTime))*NaN;

    % LongVel
    indata.longvel.c1 = ones(size(indata.cTime))*NaN;
    indata.longvel.c2 = ones(size(indata.cTime))*NaN;
    indata.longvel.c3 = ones(size(indata.cTime))*NaN;
    indata.longvel.c4 = ones(size(indata.cTime))*NaN;
    indata.longvel.c5 = ones(size(indata.cTime))*NaN;
    indata.longvel.c6 = ones(size(indata.cTime))*NaN;
    indata.longvel.c7 = ones(size(indata.cTime))*NaN;
    indata.longvel.c8 = ones(size(indata.cTime))*NaN;
    indata.longvel.c9 = ones(size(indata.cTime))*NaN;
    indata.longvel.c10 = ones(size(indata.cTime))*NaN;

    % LatVel
    indata.latvel.c1 = ones(size(indata.cTime))*NaN;
    indata.latvel.c2 = ones(size(indata.cTime))*NaN;
    indata.latvel.c3 = ones(size(indata.cTime))*NaN;
    indata.latvel.c4 = ones(size(indata.cTime))*NaN;
    indata.latvel.c5 = ones(size(indata.cTime))*NaN;
    indata.latvel.c6 = ones(size(indata.cTime))*NaN;
    indata.latvel.c7 = ones(size(indata.cTime))*NaN;
    indata.latvel.c8 = ones(size(indata.cTime))*NaN;
    indata.latvel.c9 = ones(size(indata.cTime))*NaN;
    indata.latvel.c10 = ones(size(indata.cTime))*NaN;

    % Heading
    indata.resim_heading.c1 = ones(size(indata.cTime))*NaN;
    indata.resim_heading.c2 = ones(size(indata.cTime))*NaN;
    indata.resim_heading.c3 = ones(size(indata.cTime))*NaN;
    indata.resim_heading.c4 = ones(size(indata.cTime))*NaN;
    indata.resim_heading.c5 = ones(size(indata.cTime))*NaN;
    indata.resim_heading.c6 = ones(size(indata.cTime))*NaN;
    indata.resim_heading.c7 = ones(size(indata.cTime))*NaN;
    indata.resim_heading.c8 = ones(size(indata.cTime))*NaN;
    indata.resim_heading.c9 = ones(size(indata.cTime))*NaN;
    indata.resim_heading.c10 = ones(size(indata.cTime))*NaN;

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
%plots.fcw = plot(0,0, 'ks', 'MarkerSize', 10, 'MarkerFaceColor',[1 0 0]);


% tram
latsize_tram1=[-1,-1, 1, 1, -1]; %x position: left upper corner, left lower, right lower, upper right, left upper again to close the square
longsize_tram1=[0, -5, -5, 0, 0]; %y position: left upper corner, left lower, right lower, upper right, left upper again to close the square
latmidsec_tram1=[-0.5, -0.5, 0.5, 0.5, -0.5]; %size of middlesection between tram wagons
longmidsec_tram1=[-5,-6,-6,-5, -5];
latsize_tram2=[-1,-1, 1, 1, -1];
longsize_tram2=[-6, -11, -11, -6, -6];
plots.tram1=plot(latsize_tram1,longsize_tram1, 'b-', 'Linewidth', 3);
plots.middle1=plot(latmidsec_tram1,longmidsec_tram1, 'b-', 'Linewidth', 3);
plots.tram2=plot(latsize_tram2,longsize_tram2, 'b-', 'Linewidth', 3);

grid on
xlabel('Latitude (m)');
ylabel('Longitude (m)');

%axis([50 -50 -5 50])
axis([-20 20 -15 30])


%Create text field
t = uicontrol('style','edit','String',30,'BackgroundColor',[1 1 1],'position',[450 20 60 20]);
uicontrol('style','text','String','Max distance [m] :','position',[350 21 100 18])


%Create slider with listener
h = uicontrol('style','slider','Min',1,'Max',indata.tot,'Value',1,'SliderStep',[1/indata.tot 1/indata.tot],'units','pixel','position',[20 20 300 20]);
% plot 
addlistener(h,'ContinuousValueChange',@(hObject, event) makeplot(hObject,event,t,indata,plots));
% warn
addlistener(h,'ContinuousValueChange',@(hObject, event) fcws(hObject,event,t,indata,plots));

% lamps
%u1=uicontrol('style','edit','String',' ','BackgroundColor',@fcws, 'position',[525 300 20 20]);
%addlistener(u1,'ContinousValueChange',@(hObject, event) fcws(hObject,event,t,indata,plots));
%{
%create a text box that changes colors
u2=uicontrol('style','edit','String',' ','BackgroundColor',color2, 'position',[525 270 20 20]);
addlistener(u2,'BackgroundColor',@(hObject, event) makeplot(hObject,event,t,indata,plots));
%create a text box that changes colors
u3=uicontrol('style','edit','String',' ','BackgroundColor',color3, 'position',[525 240 20 20]);
addlistener(u3,'BackgroundColor',@(hObject, event) makeplot(hObject,event,t,indata,plots)); 
%}


%end


function makeplot(hObject,event,t,indata,plots)
new_refidx = round(get(hObject,'Value'));

set(hObject,'Value',new_refidx);

max_distance = str2num(get(t,'String'));

%New struct type
max_rm_range = 30;
heading = atan(indata.resim_heading.c1(new_refidx));
lane_width = 3.1;
%end

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

%Show ctime
title(strcat('cTime: ',num2str(indata.cTime(new_refidx))));
axis([-20 20 -15 30])
%axis([50 -50 -5 50])

end


function [redlamp,yellamp,bluelamp]=fcws(hObject,event,t,indata,plots)
new_refidx = round(get(hObject,'Value'));
set(hObject,'Value',new_refidx);
max_distance = str2num(get(t,'String'));

tramSpeed = 30;
crashMeters = 0.25;
dangerWidth = 1.5;


 if indata.resim_latpos.b1(new_refidx) + indata.latvel.c1(new_refidx) < dangerWidth & indata.resim_latpos.b1(new_refidx) + indata.latvel.c1(new_refidx) >-dangerWidth & indata.resim_latpos.b1(new_refidx) ~=0
     if ((indata.resim_longpos.b1(new_refidx) - tramSpeed/3.6)/indata.longvel.c1(new_refidx)) <= 1
         disp("Red lamp ")
         redlamp=[1 0 0];
         u1=uicontrol('style','edit','String',' ','BackgroundColor',redlamp, 'position',[525 300 20 20]);
         %addlistener(u1,'ContinousValueChange',@(hObject, event) fcws(hObject,event,t,indata,plots));
     elseif ((indata.resim_longpos.b1(new_refidx) - tramSpeed/3.6)/indata.longvel.c1(new_refidx))  <= 3
         disp("Yellow")
         yellamp=[1 1 0];
         u2=uicontrol('style','edit','String',' ','BackgroundColor',yellamp, 'position',[525 300 20 20]);
         %addlistener(u2,'ContinousValueChange',@(hObject, event) fcws(hObject,event,t,indata,plots));
     elseif ((indata.resim_longpos.b1(new_refidx) - tramSpeed/3.6)/indata.longvel.c1(new_refidx))  <= 5
         disp("Blue")
         bluelamp=[0 0 1];
         u3=uicontrol('style','edit','String',' ','BackgroundColor',bluelamp, 'position',[525 300 20 20]);
         %addlistener(u3,'ContinousValueChange',@(hObject, event) fcws(hObject,event,t,indata,plots));
     end
     
 else
         whitelamp = [1 1 1];
         u1=uicontrol('style','edit','String',' ','BackgroundColor',whitelamp, 'position',[525 300 20 20]);
         %addlistener(u1,'ContinousValueChange',@(hObject, event) fcws(hObject,event,t,indata,plots));
         u2=uicontrol('style','edit','String',' ','BackgroundColor',whitelamp, 'position',[525 300 20 20]);
         %addlistener(u1,'ContinousValueChange',@(hObject, event) fcws(hObject,event,t,indata,plots));
         u3=uicontrol('style','edit','String',' ','BackgroundColor',whitelamp, 'position',[525 300 20 20]);
         %addlistener(u1,'ContinousValueChange',@(hObject, event) fcws(hObject,event,t,indata,plots));
 end


end