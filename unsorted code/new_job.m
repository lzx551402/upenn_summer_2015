clear
clc
load Calib_Results.mat fc cc;
I=imread('img/gaze3.jpg');
color=I;
I=rgb2gray(I);
raw=I;
%%
color=imread('img/gaze3.jpg');
%%
init=get_points(I,0,0,1);
P=get_points(I,[init(2) init(1)],200,10);
para_irisL=ellipseFitting(P);
%%
[color,L_Ci,L_Ce,L_g]=gaze_direction_estimation(color,para_irisL,fc,cc);
%%
init=get_points(I,0,0,1);
P=get_points(I,[init(2) init(1)],200,10);
para_irisR=ellipseFitting(P);
[color,R_Ci,R_Ce,R_g]=gaze_direction_estimation(color,para_irisR,fc,cc);
%%
[sp,dis]=show_gaze(L_Ce,R_Ce,L_Ci,R_Ci,L_g,R_g);
%%
Npoint=3;
img_color=imread('img/gaze3.JPG');
gtL=get_points(img_color,[para_irisL(2),para_irisL(1)],50,Npoint);
gtR=get_points(img_color,[para_irisR(2),para_irisR(1)],50,Npoint);

intrinsic_matrix=[fc(1) 0 cc(1);
    0 fc(2) cc(2);
    0 0 1];
%%
for i=1:Npoint
    sp_v(i,:)=back_projection(gtR(i,:),gtL(i,:),intrinsic_matrix,...
    R_Ce',L_Ce');
end
%%
para=[L_Ce';R_Ce'];
para=[sp_v;para];
intrinsic_para=[fc(1) fc(2) cc(1) cc(2)];
error_before=bundle_adjustment(para,gtL,gtR,intrinsic_para);
[para,error_after]=lsqnonlin(@bundle_adjustment,para,[],[],[],gtL,gtR,intrinsic_para);
error_before
error_after
offsetL=para(Npoint+1,:)-L_Ce';
offsetR=para(Npoint+2,:)-R_Ce';
sp_v_update=para([1:Npoint],:);
%%
new_L_g=L_Ci(1:3)'-(L_Ce+offsetL');
new_R_g=R_Ci(1:3)'-(R_Ce+offsetR');
[sp_new,dis_new]=show_gaze(L_Ce,R_Ce,L_Ci,R_Ci,new_L_g,new_R_g);