function [] = image_undistortion(base_name)
addpath(genpath(pwd));
strR=[base_name,'_r.bmp'];
strL=[base_name,'_l.bmp'];
%those params are obtained from Uyun Soo's calibration.
Center_y = 643.696778;
Center_x = 472.103088;
omega = 0.001553;
%for right image
inPath = fullfile('data',strR);
outPath = fullfile('bin',base_name,['u_',strR]);
fprintf('start to undistort right img...\n');
undistortion_without_filter (inPath, outPath, Center_x, Center_y, omega);
fprintf('done!\n');
%for left image
inPath = fullfile('data',strL);
outPath = fullfile('bin',base_name,['u_',strL]);
fprintf('start to undistort left img...\n');
undistortion_without_filter (inPath, outPath, Center_x, Center_y, omega);
fprintf('done!\n');