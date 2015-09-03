function [sp,dis]=show_gaze(mirrorCenterL,mirrorCenterR,g_L,g_R)
figure;
[x,y,z]=sphere(30);
r_m=0.5;
r_eyeball=7.8;
%eyeball L
X=x*r_eyeball+mirrorCenterL(1);
Y=y*r_eyeball+mirrorCenterL(2);
Z=z*r_eyeball+mirrorCenterL(3);
hold on;
mesh(X,Y,Z);
text(mirrorCenterL(1)+10,mirrorCenterL(2),mirrorCenterL(3),'Left Eye');
%eyeball R
X=x*r_eyeball+mirrorCenterR(1);
Y=y*r_eyeball+mirrorCenterR(2);
Z=z*r_eyeball+mirrorCenterR(3);
mesh(X,Y,Z);
text(mirrorCenterR(1)+10,mirrorCenterR(2),mirrorCenterR(3),'Right Eye');
%
N=cross(g_R,g_L);
tR=dot(cross((mirrorCenterL-mirrorCenterR),g_L),N)/norm(N)^2;
tL=dot(cross((mirrorCenterL-mirrorCenterR),g_R),N)/norm(N)^2;
spR=mirrorCenterR+tR*g_R;
spL=mirrorCenterL+tL*g_L;
sp=(spR+spL)/2;
dis=norm(spR-spL);
if tR>500 | tR < 200
    tR=200;
end
if tL>500 | tL < 200
    tL=200;
end
if tR<0
    tR=200;
end
if tL<0
    tL=200;
end
%gaze L
temp=mirrorCenterL+g_L*tL;
X=[mirrorCenterL(1),temp(1)];
Y=[mirrorCenterL(2),temp(2)];
Z=[mirrorCenterL(3),temp(3)];
line(X,Y,Z,'Color',[0 0 0]);
%gaze R
temp=mirrorCenterR+g_R*tR;
X=[mirrorCenterR(1),temp(1)];
Y=[mirrorCenterR(2),temp(2)];
Z=[mirrorCenterR(3),temp(3)];
line(X,Y,Z,'Color',[0 0 0]);
view(30,10)
grid on;
xlabel('x'),ylabel('y'),zlabel('z');
axis equal;
hold off;
