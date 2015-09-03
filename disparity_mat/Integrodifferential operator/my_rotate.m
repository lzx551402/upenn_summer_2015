function [out]=my_rotate(in,angle)
A=[cosd(angle) -sind(angle);sind(angle) cosd(angle)];
out=A*[in(1);in(2)];