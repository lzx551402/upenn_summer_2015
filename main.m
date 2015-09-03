%%
clear
clc
close all
addpath(genpath(pwd));
base_name = 'new2';
load mat/2+10.mat fc cc;
%%
mkdir(['bin/' base_name]);
undistortion(base_name);
%%
feature_matching(base_name);
%%
image_rectification(base_name);
%%
undistortion_with_filter(base_name);
I=imread(fullfile('bin',base_name,['u_',base_name,'_u.bmp']));
%%
[aligned_img,D]=image_alignment(base_name);
imagesc(D);
%%
para_irisL=ellipseParams(I);
%%
para_irisR=ellipseParams(I);
%%
img_show=I;
[img_show,LimbusCenter_R,CorneaCenter_R,Gaze_R]=gaze_estimation(img_show,para_irisR,fc,cc,1);
[img_show,LimbusCenter_L,CorneaCenter_L,Gaze_L]=gaze_estimation(img_show,para_irisL,fc,cc,1);
imshow(img_show);
%%
visualization(CorneaCenter_L,CorneaCenter_R,...
    LimbusCenter_L,LimbusCenter_R,...
    Gaze_L,Gaze_R);
%%
nPoints=3;
sp_to_user=get_sp(aligned_img,D,nPoints);
gtL=get_points(img_show,[para_irisL(2),para_irisL(1)],100,nPoints);
gtR=get_points(img_show,[para_irisR(2),para_irisR(1)],100,nPoints);
%%
%use bundle adjustment to update scene points & mirror center
para=[CorneaCenter_L';CorneaCenter_R'];
para=[sp_to_user;para];
intrinsic_para=[fc(1) fc(2) cc(1) cc(2)];
error_before=bundle_adjustment(para,gtL,gtR,intrinsic_para);
disp(error_before);
[para,error_after]=lsqnonlin(@bundle_adjustment,para,[],[],[],gtL,gtR,intrinsic_para);
disp(error_before);
disp(error_after)
offsetL=para(nPoints+1,:)-CorneaCenter_L';
offsetR=para(nPoints+2,:)-CorneaCenter_R';
disp(offsetL);
disp(offsetR);
Updated_CorneaCenter_L=CorneaCenter_L+offsetL';
Updated_CorneaCenter_R=CorneaCenter_R+offsetR';
sp_v_update=para(1:nPoints,:);
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
%%
Npoint=5;
%gtL2=get_points(img_show,[para_irisL(2),para_irisL(1)],100,Npoint);
gtR2=get_points(img_show,[para_irisR(2),para_irisR(1)],100,Npoint);
%sp_to_user2=get_sp(aligned_img,D,Npoint);
%%
com=I;
com(round(gtL2(2)),round(gtL2(1)),:)=[255,255,255];
com(round(gtR2(2)),round(gtR2(1)),:)=[255,255,255];
crop1=imcrop(com,[para_irisR(1)-200,para_irisR(2)-150,400,300]);
crop2=imcrop(com,[para_irisL(1)-200,para_irisL(2)-150,400,300]);
imshow([crop1,crop2]);
%%
intrinsic_matrix=[fc(1) 0 cc(1);
    0 fc(2) cc(2);
    0 0 1];
[sp,dis]=back_projection(gtL2,gtR2,intrinsic_matrix,Updated_CorneaCenter_L',Updated_CorneaCenter_R');
sp
dis
%%
close all;
img_show=I;
H1=figure;
imagesc(D);
H2=figure;
imshow(aligned_img);
nPoints=2;
[x,y]=ginput(nPoints);
close all;
%%
load mat/platform_calib.mat
scale=100.3841/norm(median_transL-median_transR);
pro=uint8(zeros(size(img_show)));
com=img_show;
for i=x(1):6:x(2)
    for j=y(1):6:y(2)
        
        depth=D(round(j),round(i));
        if depth == Inf
            continue;
        end
        xx=depth/568.99*(i-643.21055941);%params.CameraParameters1.PrincipalPoint(1));
        yy=depth/568.99*(j-477.982801038);%params.CameraParameters1.PrincipalPoint(2));
        sp=[xx,yy,depth];
        sp_c=median_rotL^-1*sp'+scale*median_transL';
        r_eyeball=7.8;
        Reflection_R=solve_equation(Updated_CorneaCenter_R',sp_c',r_eyeball);
        Reflection_L=solve_equation(Updated_CorneaCenter_L',sp_c',r_eyeball);
        pointR=[fc(1)*Reflection_R(1)/Reflection_R(3)+cc(1),fc(2)*Reflection_R(2)/Reflection_R(3)+cc(2)];
        pointL=[fc(1)*Reflection_L(1)/Reflection_L(3)+cc(1),fc(2)*Reflection_L(2)/Reflection_L(3)+cc(2)];
        pro(round(pointR(2)),round(pointR(1)),:)=aligned_img(round(j),round(i),:);
        pro(round(pointL(2)),round(pointL(1)),:)=aligned_img(round(j),round(i),:);
    end
end
%%
figure;
crop1=imcrop(com,[para_irisR(1)-200,para_irisR(2)-150,400,300]);
crop2=imcrop(pro,[para_irisR(1)-200,para_irisR(2)-150,400,300]);
[crop_r,crop_c]=size(crop2);
crop_c = crop_c/3;
for i=1:crop_r
    for j=1:crop_c
        if sum(crop2(i,j,:)) ~= 0           
            crop1(i,j,:) = [255,255,255];
            for k=fliplr(1:crop_c)
                if sum(crop2(i,k,:)) ~= 0
                    crop1(i,k,:) = [255,255,255];
                    break;
                end
            end
            break;
        end
    end
end

crop3=imcrop(com,[para_irisL(1)-200,para_irisL(2)-150,400,300]);
crop4=imcrop(pro,[para_irisL(1)-200,para_irisL(2)-150,400,300]);
for i=1:crop_r
    for j=1:crop_c
        if sum(crop4(i,j,:)) ~= 0           
            crop3(i,j,:) = [255,255,255];
            for k=fliplr(1:crop_c)
                if sum(crop4(i,k,:)) ~= 0
                    crop3(i,k,:) = [255,255,255];
                    break;
                end
            end
            break;
        end
    end
end

imshow([crop1 crop2;crop3 crop4]);
hold off;
%%
close all;
Updated_Gaze_L=LimbusCenter_L(1:3)'-Updated_CorneaCenter_L;
Updated_Gaze_R=LimbusCenter_R(1:3)'-Updated_CorneaCenter_R;
visualization(Updated_CorneaCenter_L,Updated_CorneaCenter_R,...
    LimbusCenter_L,LimbusCenter_R,...
    Updated_Gaze_L,Updated_Gaze_R);
hold on;
[x,y,z]=sphere(30);
r_m=0.5;
r_eyeball=7.8;
% %camera pupil
% X=x*2*r_m*5;
% Y=y*2*r_m*5;
% Z=z*2*r_m*5;
% mesh(X,Y,Z);
% text(0,0,0, '   Camera Pupil')
%eyeball L
X=x*r_eyeball+CorneaCenter_L(1);
Y=y*r_eyeball+CorneaCenter_L(2);
Z=z*r_eyeball+CorneaCenter_L(3);
hold on;
m = mesh(X,Y,Z);
set(m,'edgecolor','black','facealpha',0,'linewidth',1)
%eyeball R
X=x*r_eyeball+CorneaCenter_R(1);
Y=y*r_eyeball+CorneaCenter_R(2);
Z=z*r_eyeball+CorneaCenter_R(3);
m = mesh(X,Y,Z);
set(m,'edgecolor','black')