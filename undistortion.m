function [] = undistortion(base_name)
addpath(genpath(pwd));
strR=[base_name,'_r.bmp'];
strL=[base_name,'_l.bmp'];
omega = 0.001553;
%for right image
Center_y = 643.696778;
Center_x = 472.103088;
In_Path = fullfile('data',strR);
Out_Path = fullfile('bin',base_name,['u_',strR]);
fprintf('start to undistort right img...\n');
undistortion_without_filter (In_Path, Out_Path, Center_x, Center_y, omega);
fprintf('done!\n');
%for left image
In_Path = fullfile('data',strL);
Out_Path = fullfile('bin',base_name,['u_',strL]);
fprintf('start to undistort left img...\n');
undistortion_without_filter (In_Path, Out_Path, Center_x, Center_y, omega);
fprintf('done!\n');