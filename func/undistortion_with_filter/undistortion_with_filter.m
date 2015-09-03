function I2 = undistortion_with_filter(base_name)
load mat/2+10.mat
I=imrotate(imread(strcat('data/',base_name,'_u.bmp')),180);
KK = [fc(1) alpha_c*fc(1) cc(1);0 fc(2) cc(2) ; 0 0 1];
I = double(I);
%% SHOW THE ORIGINAL IMAGE:
figure(2);
image(uint8(I));
title('Original image (with distortion) - Stored in array I')
drawnow;

%% UNDISTORT THE IMAGE:
fprintf(1,'Computing the undistorted image...\n')

[Ipart_1] = rect(I(:,:,1),eye(3),fc,cc,kc,alpha_c,KK);
[Ipart_2] = rect(I(:,:,2),eye(3),fc,cc,kc,alpha_c,KK);
[Ipart_3] = rect(I(:,:,3),eye(3),fc,cc,kc,alpha_c,KK);
[ny,nx]=size(I);
nx=nx/3;
I2 = ones(ny, nx,3);
I2(:,:,1) = Ipart_1;
I2(:,:,2) = Ipart_2;
I2(:,:,3) = Ipart_3;

fprintf(1,'done!\n')

figure(3);
I2=uint8(I2);
image(I2);

title('Undistorted image - Stored in array I2')
drawnow;

%% SAVE THE IMAGE IN FILE:
imwrite(imrotate(uint8(round(I2)),180),fullfile('bin',base_name,['u_',base_name,'_u.bmp']));
