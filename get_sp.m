function [sp_to_user]=get_sp(aligned_img,D,nPoints)
load mat/platform_calib.mat
close all;
figure;
imagesc(D);
figure;
imshow(aligned_img);
[x,y]=ginput(nPoints);
scale=100.3841/norm(median_transL-median_transR);
close all;
sp_to_user=zeros(nPoints,3);
for i=1:nPoints        
    z_3d=D(round(y(i)),round(x(i)));
    if z_3d == Inf
        continue;
    end
    x_3d=z_3d/568.99*(x(i)-643.21055941);%params.CameraParameters1.PrincipalPoint(1));
    y_3d=z_3d/568.99*(y(i)-477.982801038);%params.CameraParameters1.PrincipalPoint(2));
    sp=[x_3d,y_3d,z_3d];
    sp_to_user(i,:)=median_rotL^-1*sp'+scale*median_transL';
end