function []=visualize_system(CorneaCenter_L,CorneaCenter_R,...
    Gaze_L,Gaze_R)

close all;
[sp,dis]=show_gaze(CorneaCenter_L,CorneaCenter_R,Gaze_L,Gaze_R);
hold on;
load mat/platform_calib.mat
load mat/stereo_params.mat
scale=abs(norm(params.TranslationOfCamera2)/norm(median_transR-median_transL));
Xr=median_rotR^-1*[50;0;0]+scale*median_transR';
Yr=median_rotR^-1*[0;50;0]+scale*median_transR';
Zr=median_rotR^-1*[0;0;50]+scale*median_transR';
comb1=[scale*median_transR' Xr];
comb2=[scale*median_transR' Yr];
comb3=[scale*median_transR' Zr];
line(comb1(1,:),comb1(2,:),comb1(3,:));
line(comb2(1,:),comb2(2,:),comb2(3,:));
line(comb3(1,:),comb3(2,:),comb3(3,:),'Color',[1 0 0]);
hold on;

Xu=[50;0;0];
Yu=[0;50;0];
Zu=[0;0;50];
comb1=[[0;0;0] Xu];
comb2=[[0;0;0] Yu];
comb3=[[0;0;0] Zu];
line(comb1(1,:),comb1(2,:),comb1(3,:));
line(comb2(1,:),comb2(2,:),comb2(3,:));
line(comb3(1,:),comb3(2,:),comb3(3,:),'Color',[1 0 0]);

Xl=median_rotL^-1*[50;0;0]+scale*median_transL';
Yl=median_rotL^-1*[0;50;0]+scale*median_transL';
Zl=median_rotL^-1*[0;0;50]+scale*median_transL';
comb1=[scale*median_transL' Xl];
comb2=[scale*median_transL' Yl];
comb3=[scale*median_transL' Zl];
grid on;
line(comb1(1,:),comb1(2,:),comb1(3,:));
line(comb2(1,:),comb2(2,:),comb2(3,:));
line(comb3(1,:),comb3(2,:),comb3(3,:),'Color',[1 0 0]);

[x,y,z]=sphere(30);
r_m=0.3;
%user-facing camera
X=x*2*r_m*5;
Y=y*2*r_m*5;
Z=z*2*r_m*5;
mesh(X,Y,Z);
text(0,0,0, '   User-facing Camera')
%left camera
X=x*2*r_m*5+scale*median_transL(1);
Y=y*2*r_m*5+scale*median_transL(2);
Z=z*2*r_m*5+scale*median_transL(3);
mesh(X,Y,Z);
text(scale*median_transL(1),scale*median_transL(2),scale*median_transL(3), '   Left Camera')
%right camera
X=x*2*r_m*5+scale*median_transR(1);
Y=y*2*r_m*5+scale*median_transR(2);
Z=z*2*r_m*5+scale*median_transR(3);
mesh(X,Y,Z);
text(scale*median_transR(1),scale*median_transR(2),scale*median_transR(3), '   Right Camera')
