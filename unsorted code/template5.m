%%
clear
clc
close all
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
offset=[0 0 5];
mirrorCenterR=[paraR(1) paraR(2) paraR(3)]+offset;
mirrorCenterL=[paraL(1) paraL(2) paraL(3)]+offset;
%% 
Npoint=16;
img_color=imread('img/test1.jpg');
gtL=get_points(img_color,[ciL(1),ciL(2)],100,Npoint);
gtR=get_points(img_color,[ciR(1),ciR(2)],100,Npoint);

%%
for i=1:Npoint
sp=[sp_v(i,1) sp_v(i,2) -5]+[-13.5,-6.5,0];
sp_gt=sp;
r_eyeball=7.8;
R_R=solve_equation(mirrorCenterR,sp,r_eyeball);
pointR=[fc(1)*R_R(1)/R_R(3)+cc(1),fc(2)*R_R(2)/R_R(3)+cc(2)];
R_L=solve_equation(mirrorCenterL,sp,r_eyeball);
pointL=[fc(1)*R_L(1)/R_L(3)+cc(1),fc(2)*R_L(2)/R_L(3)+cc(2)];
sp=back_projection(pointR,pointL,intrinsic_matrix,mirrorCenterR,mirrorCenterL);
sp

%%
gtR=gtR_v(i,:);
gtL=gtL_v(i,:);
%%
para=[mirrorCenterL;mirrorCenterR];
para=[sp;para];
intrinsic_para=[fc(1) fc(2) cc(1) cc(2)];
error_before=bundle_adjustment(para,gtL,gtR,intrinsic_para);
[para,error_after]=lsqnonlin(@bundle_adjustment,para,[],[],[],gtL,gtR,intrinsic_para);
offsetL=para(2,:)-mirrorCenterL
offsetR=para(3,:)-mirrorCenterR
error_before
error_after
%%
sp_new=para(1,:);
sp_vv(i,:)=sp_new;
sp_gt
sp_new-sp_gt
mirrorCenterL=para(2,:);
mirrorCenterR=para(3,:);
R_R=solve_equation(mirrorCenterR,sp_new,r_eyeball);
pointR_new=[fc(1)*R_R(1)/R_R(3)+cc(1),fc(2)*R_R(2)/R_R(3)+cc(2)];
R_L=solve_equation(mirrorCenterL,sp_new,r_eyeball);
pointL_new=[fc(1)*R_L(1)/R_L(3)+cc(1),fc(2)*R_L(2)/R_L(3)+cc(2)];
%%
img_color=imread('img/test1.jpg');
close all;
img_color(round(pointR(2)),round(pointR(1)),:)=[255;0;0];
img_color(round(pointL(2)),round(pointL(1)),:)=[255;0;0];
img_color(round(gtR(2)),round(gtR(1)),:)=[0;255;255];
img_color(round(gtL(2)),round(gtL(1)),:)=[0;255;255];
img_color(round(pointR_new(2)),round(pointR_new(1)),:)=[255;255;255];
img_color(round(pointL_new(2)),round(pointL_new(1)),:)=[255;255;255];

img_R=img_color(pointR(2)-70:pointR(2)+70,pointR(1)-70:pointR(1)+70,:);
img_L=img_color(pointL(2)-70:pointL(2)+70,pointL(1)-70:pointL(1)+70,:);
figure;
hold on;
img_com=[img_L img_R];
imshow(img_com);
pause
end
%%
show_everything(sp_vv,mirrorCenterR+offsetR,mirrorCenterL+offsetL,img_color,fc)