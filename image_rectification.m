function []=image_rectification(base_name)
addpath(genpath(pwd));
%%
[TL,TR,err]=rectifyImageU(base_name);
%%
I=imread(fullfile('bin',base_name,['rectified_',base_name,'_l.bmp']));
I_l=imresize(I,[960,1280]);
imwrite(I_l,fullfile('bin',base_name,['resized_',base_name,'_l.bmp']));

I=imread(fullfile('bin',base_name,['rectified_',base_name,'_r.bmp']));
I_r=imresize(I,[960,1280]);
imwrite(I_r,fullfile('bin',base_name,['resized_',base_name,'_r.bmp']));

save(fullfile('bin',base_name,['rec_',base_name,'.mat']),'TL','TR','err');