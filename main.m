%%
% run this section to start the code
clear
clc
close all
addpath(genpath(pwd));
base_name = 'new2';% change 'base_name' to the name your image collection
mkdir(['bin/' base_name]);
load mat/2+10.mat fc cc;
%%
% run this section to process stereo image and user image
image_undistortion(base_name);
feature_matching(base_name);
image_rectification(base_name);
undistortion_with_filter(base_name);
close all;
%%
img_user=imread(fullfile('bin',base_name,['u_',base_name,'_u.bmp']));
img_left=imread(fullfile('bin',base_name,['u_',base_name,'_l.bmp']));
img_right=imread(fullfile('bin',base_name,['u_',base_name,'_r.bmp']));
%%
% this blank section is for future modification so that MATLAB can directly
% run C++ 3D reconstruction code in Linux
%%
% run this section to align the depth map
[D]=image_alignment(base_name);
imagesc(D);
%%
% run this section to detect eyes
[left_c, right_c] = eye_detector(img_user);
%%
% run this section for ellipse fitting
para_irisL=ellipse_params(img_user, left_c);
para_irisR=ellipse_params(img_user, right_c);
showImg=img_user;
[showImg,LimbusCenter_R,CorneaCenter_R,Gaze_R]=gaze_estimation(showImg,para_irisR,fc,cc,1);
[showImg,LimbusCenter_L,CorneaCenter_L,Gaze_L]=gaze_estimation(showImg,para_irisL,fc,cc,1);
%%
% visualize the limbus and gaze in the image
imshow(showImg);
%%
% visualize the whole system
visualize_system(CorneaCenter_L,CorneaCenter_R,...
    Gaze_L,Gaze_R);
% -------------------------------------------------------------------------
% now you have all the params of the whole system
% -------------------------------------------------------------------------
%%
% in this section, you're going to pick [nPoints] pairs of correspinding points on
% left, right and looking-in image.
nPoints=3;
sp_to_user=get_sp_to_user(aligned_img,D,nPoints);
gtL=get_imaged_points(img_show,[para_irisL(2),para_irisL(1)],100,nPoints);
gtR=get_imaged_points(img_show,[para_irisR(2),para_irisR(1)],100,nPoints);
%%
% use bundle adjustment to update scene points & mirror center
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
% -------------------------------------------------------------------------
% now you have a optimized system
% -------------------------------------------------------------------------