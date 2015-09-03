%each sections is independent
%use 'Run Section' to run this code

%%
%single camera calibration
data_folder = 'user_test';
squareSizeInMM = 24.5;
images = imageSet(fullfile('data',data_folder));
imageFileNames = images.ImageLocation;
[imagePoints, boardSize] = detectCheckerboardPoints(imageFileNames);
worldPoints = generateCheckerboardPoints(boardSize,squareSizeInMM);
params = estimateCameraParameters(imagePoints,worldPoints);
showReprojectionErrors(params);
%%
%visualize reprojection (if you want)
for i=1:images.Count
    figure;
    imshow(imageFileNames{i});
    hold on;
    plot(imagePoints(:,1,i), imagePoints(:,2,i),'go');
    plot(params.ReprojectedPoints(:,1,i), params.ReprojectedPoints(:,2,i),'r+');
    legend('Detected Points','ReprojectedPoints');
    hold off;
    pause
    close all;
end
%%
%stereo cameras calibration
squareSizeInMM = 20;
imageDir = fullfile('data');
leftImages = imageSet(fullfile(imageDir,'left'));
rightImages = imageSet(fullfile(imageDir,'right'));
images1 = leftImages.ImageLocation;
images2 = rightImages.ImageLocation;
[imagePoints, boardSize] = detectCheckerboardPoints(images1,images2);
worldPoints = generateCheckerboardPoints(boardSize,squareSizeInMM);
im = read(leftImages,1);
params = estimateCameraParameters(imagePoints,worldPoints);
showReprojectionErrors(params);
%%
%undistort image using intrinsic params
imageDir = fullfile('data');
I=imread('data/user_Test/1.bmp');
J = undistortImage(I, params);
imshow(J);
%%
%rectification given stereo calibration params
%if the FOV is narrow, you can use this code
%or you should use 'image_rectification.m'
I1=imread('data/left.bmp');
I2=imread('data/right.bmp');
[J1,J2] = rectifyStereoImages(I1,I2, params,'OutputView','valid');
figure
imshow(J1);
figure
imshow(J2);