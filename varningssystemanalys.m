%function Sliderplot


% data
data = load('path to log file');
source = data;

% length
indata.tot = length(ctime);
indata.cTime = double(ctime);

% CAN-data
can_cTime = ctime;

%MATLAB resim data
    % LongPos
    indata.resim_longpos.b1 = [longpos]';

    % LatPos
    indata.resim_latpos.b1 = [latpos]';

    %LongVel
    indata.longvel.c1 = [longvel]';

    %LatVel
    indata.latvel.c1 = [latvel]';

    % Tram Speed & yaw
    indata.tramSpeed = [speed]';
    indata.yaw = [yaw]';
    
    % Width
    indata.width.b1 = [width]';
    
    % Length
    indata.length.b1 = [length]';
    
    % FreeSpace
    indata.fs(1).fs = [FS distance];
    
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
for k = 1:10
    plots.OBJ(k) = plot(0,0, 'bs','MarkerSize', 10);
end
% fs as stars
for k= 1:60
    plots.FS(k) = plot(0,0,'g*');
end

%object latpos
objectLatpos = [indata.b(1).latpos, indata.b(2).latpos, indata.b(3).latpos, indata.b(4).latpos, indata.b(5).latpos, indata.b(6).latpos, indata.b(7).latpos, indata.b(8).latpos, indata.b(9).latpos, indata.b(10).latpos];
%object latvel
objectLatvel = [indata.c(1).latvel, indata.c(2).latvel, indata.c(3).latvel, indata.c(4).latvel, indata.c(5).latvel, indata.c(6).latvel, indata.c(7).latvel, indata.c(8).latvel, indata.c(9).latvel, indata.c(10).latvel];
%object longpos
objectLongpos = [indata.b(1).longpos, indata.b(2).longpos, indata.b(3).longpos, indata.b(4).longpos, indata.b(5).longpos, indata.b(6).longpos, indata.b(7).longpos, indata.b(8).longpos, indata.b(9).longpos, indata.b(10).longpos];
%object longvel
objectLongvel = [indata.c(1).longvel, indata.c(2).longvel, indata.c(3).longvel, indata.c(4).longvel, indata.c(5).longvel, indata.c(6).longvel, indata.c(7).longvel, indata.c(8).longvel, indata.c(9).longvel, indata.c(10).longvel];
%object width
objectWidth = [indata.b(1).width, indata.b(2).width, indata.b(3).width, indata.b(4).width, indata.b(5).width, indata.b(6).width, indata.b(7).width, indata.b(8).width, indata.b(9).width, indata.b(10).width];
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
addlistener(h,'ContinuousValueChange',@(hObject, event) fcws4(hObject,indata.tramSpeed, objectLatpos, objectLatvel, objectLongpos, objectLongvel, objectWidth, FS, u, indata.yaw));
%end


function makeplot(hObject,indata,plots)
new_refidx = round(get(hObject,'Value'));

set(hObject,'Value',new_refidx);

%Update plots with objects
for k = 1:10
    set(plots.OBJ(k), 'xdata', -indata.b(k).latpos(new_refidx))
    set(plots.OBJ(k), 'ydata', indata.b(k).longpos(new_refidx))
end
%fs plotting
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
xyaw = yaw(ceil(new_refidx*2.15));
aty = 0;



for k = 1 : 10
   % a = 2ds/dt^2
   ax = (2*(latpos(new_refidx, k)-latpos(new_refidx-1, k))/0.5);
   ay = (2*(longpos(new_refidx, k)-longpos(new_refidx-1, k))/0.05);
   xlatpos = -latpos(new_refidx, k);
   xlatvel = latvel(new_refidx, k);
   xlongpos = longpos(new_refidx, k);
   xlongvel = longvel(new_refidx, k);
   xwidth = width(new_refidx, k);
   
   %analyze objects
   lightLamp(fcwsCircle(xtramSpeed, xlatpos, xlatvel, xlongpos, xlongvel, xwidth, ax, ay, aty, u, new_refidx, xyaw), u, new_refidx);
end


% Loop through each freespace sample
for k = 1 : 60
    if FS(new_refidx, k) == 300 || FS(new_refidx, k) > 50
    elseif k < 31
        lightLamp(simpleTTC(xtramSpeed, (FS(new_refidx, k)*sin((k*3)*(pi/180))), 0, (FS(new_refidx, k)*cos((k*3)*(pi/180))), 0.2, xyaw), u, new_refidx);
    else
        lightLamp(simpleTTC(xtramSpeed, (FS(new_refidx, k)*cos((k*3-90)*(pi/180))), 0, (FS(new_refidx, k)*-sin((k*3-90)*(pi/180))), 0.2, xyaw), u, new_refidx);
    end
end

end

function [val] = fcwsCircle(tramSpeed, latpos, latvel, longpos, longvel, width, ax, ay, aty, u, index, yaw)
r1 = width*1.3; % fordonets buffer-radie
r2 = 1.5;   % spårvagnens buffer-radie
val = 0;

    if (longvel > tramSpeed)    %if object drives faster than the tram, then no need to investigate it
    elseif (latpos >= -5 && -latpos <5 && latpos ~=0)   % only investigate if object is within 5m from the sides
            syms TTCij
            
            %source: https://www.hindawi.com/journals/cin/2014/761047/#EEq1
            A = (r1+r2);
            G = 0.5*(ax + ay + aty); 
            TTCma = (-(latvel-tramSpeed)/2*G) + sqrt(((-(latvel-tramSpeed)/2*G)^2)+(sqrt(A)-(latpos + longpos)/G));
            TTCmi = (-(latvel-tramSpeed)/2*G) - sqrt(((-(latvel-tramSpeed)/2*G)^2)+(sqrt(A)-(latpos + longpos)/G));
            TTC = min(TTCma, TTCmi);

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
