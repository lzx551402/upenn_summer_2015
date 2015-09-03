clear
clc
str='data/undis';
mov=VideoReader(strcat(str,'.MP4'));
mkdir(str);
for i=1:12:576
    b=read(mov,0+i);
    imwrite(b,strcat(str,'/',int2str(i),'.bmp'),'bmp');
end
%%
clear
clc
str1='data/GOPR0639';
str2='data/c_u';
mkdir(str1);
mkdir(str2);
mov_left=VideoReader(strcat(str1,'.MP4'));
%mov_right=VideoReader(strcat(str2,'.MP4'));
for i=1:60
    disp(i);
    b1=read(mov_left,400+i*100);
    %b2=read(mov_right,6000+i*100);
    imwrite(b1,strcat(str1,'/',int2str(i),'.bmp'),'bmp');
    %imwrite(b2,strcat(str2,'/',int2str(i),'.bmp'),'bmp');
end
%%
str_vec=char('72','66','62');
n=size(str_vec,1);
for i=1:n
    fileName1=strcat(str1,'/',str_vec(i,:),'.bmp');
    fileName2=strcat(str2,'/',str_vec(i,:),'.bmp');
    delete(fileName1, fileName2);
end
%%
%move image
str1='data/precision_l/5.bmp';
str2='data/precision_r/5.bmp';
movefile(str1,strcat('data/precision_test/','5_l.bmp'));
movefile(str2,strcat('data/precision_test/','5_r.bmp'));
%%
clear
clc
str1='data/SUSHAN_l';
str2='data/SUSHAN_r';
str3='data/SUSHAN_u';
mov_left=VideoReader(strcat(str1,'.mp4'));
mov_right=VideoReader(strcat(str2,'.mp4'));
mov_user=VideoReader(strcat(str3,'.mp4'));
mkdir(str1);
mkdir(str2);
mkdir(str3);
disp('start...');
for i=1:10
        b1=read(mov_left,1250+i*4-3+1967*4); 
        b2=read(mov_right,1250+i*4-3+1967*4);
        b3=read(mov_user,283+i+1967);
        b3=imrotate(b3,180);
        disp(i);
        imwrite(b1,strcat(str1,'/',int2str(i),'.bmp'),'bmp');
        imwrite(b2,strcat(str2,'/',int2str(i),'.bmp'),'bmp');
        imwrite(b3,strcat(str3,'/',int2str(i),'.bmp'),'bmp');
end

%%
images = imageSet(fullfile('data','calib_l'));
imageFileNames = images.ImageLocation;
for i=1:images.Count
    I=imread(char(imageFileNames(i)));
    figure;
    imshow(I);
    w = waitforbuttonpress;
    if w == 1 %press any key to delete
        [~,index]=fileparts(char(imageFileNames(i)));
        fileName1=strcat(str1,'/',num2str(index),'.bmp');
        fileName2=strcat(str2,'/',num2str(index),'.bmp');
        fileName3=strcat(str3,'/',num2str(index),'.bmp');
        delete(fileName1, fileName2, fileName3);
        disp(index);
        close all;
    else
        disp('continue');
        close all;
    end
end
%%
str1='data/calib_l/';
str2='data/calib_r/';
str3='data/calib_u/';
% Get all PDF files in the current folder
images = imageSet(fullfile('data','calib_r'));
imageFileNames = images.ImageLocation;
%%
for i = 1:images.Count
    % Get the file name (minus the extension)
      [~,index]=fileparts(char(imageFileNames(i)))
      copyfile(strcat(str1,index,'.bmp'), sprintf('data/calib/image%07d.bmp', i-1));
      copyfile(char(imageFileNames(i)), sprintf('data/calib/image%07d.bmp', i+images.Count-1));
      copyfile(strcat(str3,index,'.bmp'), sprintf('data/calib/image%07d.bmp', i+images.Count*2-1));
end
%%
images = imageSet(fullfile('data','calib_l'));
imageFileNames = images.ImageLocation;
%%
str_vec=char('72','66','62');
n=size(str_vec,1);
for i=1:n
    fileName1=strcat(str1,'/',str_vec(i,:),'.bmp');
    fileName2=strcat(str2,'/',str_vec(i,:),'.bmp');
    fileName3=strcat(str3,'/',str_vec(i,:),'.bmp');
    delete(fileName1, fileName2, fileName3);
end
%