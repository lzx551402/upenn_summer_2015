function [aligned_img,D]=image_alignment(base_name)
load(fullfile('bin',base_name,['rec_',base_name,'.mat']));
test=imread(fullfile('bin',base_name,['rectified_',base_name,'_l.bmp']));
for c=1:3
aligned_img(:,:,c) = imwarpU(test(:,:,c), inv(TL));
end
[re_X,re_Y]=size(test);
re_Y=re_Y/3;

fixed=rgb2gray(imread(fullfile('bin',base_name,['u_',base_name,'_l.bmp'])));
tformEstimate = imregcorr(rgb2gray(aligned_img),fixed);
Rfixed = imref2d(size(fixed));
aligned_img = imwarp(aligned_img,tformEstimate,'OutputView',Rfixed);
figure, imshowpair(fixed,aligned_img,'falsecolor');
Disp = csvread(strcat('resized_',base_name,'_l.bmp.disp.txt'));
Disp=Disp.*2;
[x,y]=find(Disp<0);
[k,~]=size(x);
for i=1:k
    Disp(x(i),y(i))=-1*Disp(x(i),y(i));
end
  Disp_re = imresize(Disp,[re_X,re_Y]);
Disp_re = imwarpU(Disp_re, inv(TL));
Disp_re = imwarp(Disp_re,tformEstimate,'OutputView',Rfixed);
figure;
clf;
imagesc(Disp_re);
load 'mat/stereo_params.mat';
Trans=params.TranslationOfCamera2;
B=norm(Trans);
focal_length1=[568.996140852, 568.988362396];
focal_length2=[568.996140852, 568.988362396];
focal_length=(sum(focal_length1)+sum(focal_length2))/4;
Disp_re=double(Disp_re);
D=B*focal_length./Disp_re;
