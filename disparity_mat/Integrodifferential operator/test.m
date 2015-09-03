clc
clear
close all;
fprintf('ff');
sR=[5 0 0];
SR=solve_equation([0 0 10],sR,5)
VrR=-SR/norm(SR);
NR=SR-[0 0 10];
NR=NR/norm(NR);
ViR=VrR-2*NR*(NR*VrR');
figure;
hold on;
p1=SR+2*VrR;
p2=SR-2*ViR;
p3=SR+2*NR;
plot([0 SR(1)],[10 SR(3)],'--r');
plot([SR(1) p1(1)],[SR(3) p1(3)],'--b');
plot([SR(1) p2(1)],[SR(3) p2(3)],'--g');
plot([SR(1) p3(1)],[SR(3) p3(3)],'--d');
axis equal;