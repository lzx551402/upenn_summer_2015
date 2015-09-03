%%
load Calib_Results.mat fc cc;
%fc=[2880 2893.7]
raw=imread('img/test1.JPG');
img_color=raw;
raw=rgb2gray(raw);

[ciL,ciR]=main(raw,[98, 105, 1208,1252],[98,105,2310,1155]);

intrinsic_matrix=[fc(1) 0 cc(1);
    0 fc(2) cc(2);
    0 0 1];
[paraL,paraR]=postProsessing(ciL,ciR,fc,cc);
%%
offset=[0 0 1.5];
mirrorCenterR=[paraR(1) paraR(2) paraR(3)]+offset;
mirrorCenterL=[paraL(1) paraL(2) paraL(3)]+offset;
%%
%get points
Npoint=16;
img_color=imread('img/test1.JPG');
gtL=get_points(img_color,[ciL(1),ciL(2)],100,Npoint);
gtR=get_points(img_color,[ciR(1),ciR(2)],100,Npoint);
%%
%use bp-euqation to get scene points
r_eyeball=7.8;
offset=[0 0 0];
m_mirrorCenterR=mirrorCenterR+offset;
m_mirrorCenterL=mirrorCenterL+offset;
sp_v=zeros(Npoint,3);
for i=1:Npoint
pR=gtR(i,:);
pR=[pR 1];
sR=intrinsic_matrix^-1*pR';
syms t
eq=(t*sR(1)-m_mirrorCenterR(1))^2+...
   (t*sR(2)-m_mirrorCenterR(2))^2+...
   (t*sR(3)-m_mirrorCenterR(3))^2-...
    r_eyeball^2;
[t]=solve(eq,'t');
t=eval(t);
t=min(t);
SR=t*sR';

VrR=-SR/norm(SR);
NR=SR-m_mirrorCenterR;
NR=NR/norm(NR);
ViR=2*(dot(NR,VrR)/dot(NR,NR))*NR-VrR;

pL=gtL(i,:);
pL=[pL 1];
sL=intrinsic_matrix^-1*pL';
syms t
eq=(t*sL(1)-m_mirrorCenterL(1))^2+...
   (t*sL(2)-m_mirrorCenterL(2))^2+...
   (t*sL(3)-m_mirrorCenterL(3))^2-...
    r_eyeball^2;
[t]=solve(eq,'t');
t=eval(t);
t=min(t);
SL=t*sL';

VrL=-SL/norm(SL);
NL=SL-m_mirrorCenterL;
NL=NL/norm(NL);
ViL=2*(dot(NL,VrL)/dot(NL,NL))*NL-VrL;

N=cross(ViR,ViL);
tR=cross((SL-SR),ViL)*N'/norm(N)^2;
tL=cross((SL-SR),ViR)*N'/norm(N)^2;
spR=SR+tR*ViR;
spL=SL+tL*ViL;
sp=(spR+spL)/2;
sp_v(i,:)=sp;

R_R_re=solve_equation(m_mirrorCenterR,sp,r_eyeball);
pointR=[fc(1)*R_R_re(1)/R_R_re(3)+cc(1),fc(2)*R_R_re(2)/R_R_re(3)+cc(2)];
p_R(i,:)=pointR;
R_L_re=solve_equation(m_mirrorCenterL,sp,r_eyeball);
pointL=[fc(1)*R_L_re(1)/R_L_re(3)+cc(1),fc(2)*R_L_re(2)/R_L_re(3)+cc(2)];
p_L(i,:)=pointL;
end
clear SL SR  sL sR R_R_re R_L_re pointR pointL sp spR spL N tR tL t pR pL NL NR ViR ViL VrR VrL
%%
%use bundle adjustment to update scene points & mirror center
para=[m_mirrorCenterL;m_mirrorCenterR];
para=[sp_v;para];
intrinsic_para=[fc(1) fc(2) cc(1) cc(2)];
error_before=bundle_adjustment(para,gtL,gtR,intrinsic_para);
[para,error_after]=lsqnonlin(@bundle_adjustment,para,[],[],[],gtL,gtR,intrinsic_para);
error_before
error_after
offsetL=para(Npoint+1,:)-m_mirrorCenterL
offsetR=para(Npoint+2,:)-m_mirrorCenterR
m_mirrorCenterL=m_mirrorCenterL+offsetL;
m_mirrorCenterR=m_mirrorCenterR+offsetR;
sp_v_update=para([1:Npoint],:);
%%
%project updated scene points onto image plane
for i=1:Npoint
    R_R_re=solve_equation(para(Npoint+2,:),sp_v_update(i,:),r_eyeball);
    pointR=[fc(1)*R_R_re(1)/R_R_re(3)+cc(1),fc(2)*R_R_re(2)/R_R_re(3)+cc(2)];
    p_R_new(i,:)=pointR;
    R_L_re=solve_equation(para(Npoint+1,:),sp_v_update(i,:),r_eyeball);
    pointL=[fc(1)*R_L_re(1)/R_L_re(3)+cc(1),fc(2)*R_L_re(2)/R_L_re(3)+cc(2)];
    p_L_new(i,:)=pointL;
end
clear pointR pointL R_R_re R_L_re
%%
img_color=imread('img/test1.JPG');
close all;
for i=1:Npoint
    img_color(round(gtR(i,2)),round(gtR(i,1)),:)=[255;0;0];
    img_color(round(gtL(i,2)),round(gtL(i,1)),:)=[255;0;0];
    img_color(round(p_R(i,2)),round(p_R(i,1)),:)=[255;255;255];
    img_color(round(p_L(i,2)),round(p_L(i,1)),:)=[255;255;255];
    img_color(round(p_R_new(i,2)),round(p_R_new(i,1)),:)=[0;255;0];
    img_color(round(p_L_new(i,2)),round(p_L_new(i,1)),:)=[0;255;0];
end

img_R=img_color(gtR(1,2)-50:gtR(1,2)+50,gtR(1,1)-50:gtR(1,1)+50,:);
img_L=img_color(gtL(1,2)-50:gtL(1,2)+50,gtL(1,1)-50:gtL(1,1)+50,:);
figure;
hold on;
img_com=[img_L img_R];
imshow(img_com);
%%
img_color=imread('img/test1.JPG');
show_everything(sp_v_update,m_mirrorCenterR+offsetR,m_mirrorCenterL+offsetL,img_color,fc)
%%
show_cube(sp_v_update);
%%
close all;
figure;
axis equal
hold on;
for i=1:7
    plot([p_L(i,1),gtL(i,1)],[p_L(i,2),gtL(i,2)],'--c');
    plot(gtL(i,1),gtL(i,2),'*r');
    plot(p_L(i,1),p_L(i,2),'*k');
    plot([p_R(i,1),gtR(i,1)],[p_R(i,2),gtR(i,2)],'--c');
    plot(gtR(i,1),gtR(i,2),'*r');
    plot(p_R(i,1),p_R(i,2),'*k');
end
for i=1:6
    X=[gtL(i,1),gtL(i+1,1)];
    Y=[gtL(i,2),gtL(i+1,2)];
    plot(X,Y,'--b');
end
X=[gtL(1,1),gtL(4,1)];
Y=[gtL(1,2),gtL(4,2)];
plot(X,Y,'--b');
X=[gtL(1,1),gtL(6,1)];
Y=[gtL(1,2),gtL(6,2)];
plot(X,Y,'--b');
X=[gtL(2,1),gtL(7,1)];
Y=[gtL(2,2),gtL(7,2)];
plot(X,Y,'--b');
%
for i=1:6
    X=[gtR(i,1),gtR(i+1,1)];
    Y=[gtR(i,2),gtR(i+1,2)];
    plot(X,Y,'--b');
end
X=[gtR(1,1),gtR(4,1)];
Y=[gtR(1,2),gtR(4,2)];
plot(X,Y,'--b');
X=[gtR(1,1),gtR(6,1)];
Y=[gtR(1,2),gtR(6,2)];
plot(X,Y,'--b');
X=[gtR(2,1),gtR(7,1)];
Y=[gtR(2,2),gtR(7,2)];
plot(X,Y,'--b');
%%
r_m=3;
[x,y,z]=sphere(30);
figure;
hold on;

axis equal;
for i=1:7
X=x*r_m+sp_v(i,1);
Y=y*r_m+sp_v(i,2);
Z=z*r_m+sp_v(i,3);
mesh(X,Y,Z);
text(sp_v(i,1),sp_v(i,2),sp_v(i,3)+2*r_m, num2str(i));
end
for i=1:6
    X=[sp_v(i,1),sp_v(i+1,1)];
    Y=[sp_v(i,2),sp_v(i+1,2)];
    Z=[sp_v(i,3),sp_v(i+1,3)];
    plot3(X,Y,Z,'--r');
end
X=[sp_v(1,1),sp_v(4,1)];
Y=[sp_v(1,2),sp_v(4,2)];
Z=[sp_v(1,3),sp_v(4,3)];
plot3(X,Y,Z,'--r');
X=[sp_v(1,1),sp_v(6,1)];
Y=[sp_v(1,2),sp_v(6,2)];
Z=[sp_v(1,3),sp_v(6,3)];
plot3(X,Y,Z,'--r');
X=[sp_v(2,1),sp_v(7,1)];
Y=[sp_v(2,2),sp_v(7,2)];
Z=[sp_v(2,3),sp_v(7,3)];
plot3(X,Y,Z,'--r');

mean_H=(norm(sp_v(4,:)-sp_v(5,:))+...
    norm(sp_v(1,:)-sp_v(6,:))+...
    norm(sp_v(2,:)-sp_v(7,:)))/3
mean_L=(norm(sp_v(1,:)-sp_v(2,:))+...
    norm(sp_v(3,:)-sp_v(4,:))+...
    norm(sp_v(6,:)-sp_v(7,:)))/3
mean_W=(norm(sp_v(4,:)-sp_v(1,:))+...
    norm(sp_v(3,:)-sp_v(2,:))+...
    norm(sp_v(5,:)-sp_v(6,:)))/3
grid on;
hold off;
xlabel('x'),ylabel('y'),zlabel('z');
