function [angle] = whereIsApple(snakeHead,apple,direction)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%y+ - prawo direction=0
%x+ = dó³ direction=1
%y- =lewo direction=2
%x- = góra direction=3
x1=snakeHead(1);
y1=snakeHead(2);
x2=apple(1);
y2=apple(2);
angle=atan2(y2-y1,x2-x1);
switch direction
    case 2
        angle=angle+pi/2;
    case 3
        angle=angle+pi;
    case 0
        angle=angle-pi/2;
end
if angle>pi
    angle=-2*pi+angle;
end
if angle<-pi
    angle=2*pi+angle;
end

angle=angle/pi;
end

