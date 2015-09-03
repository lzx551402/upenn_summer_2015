load Calib_Results.mat fc cc;
raw=imread('img/raw.JPG');
img_color=raw;
raw=rgb2gray(raw);
[ciL,ciR]=main(raw,[65, 80, 1227,1005],[60,80,1145,1815]);