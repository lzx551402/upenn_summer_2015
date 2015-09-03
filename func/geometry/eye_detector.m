function [left,right]=eye_detector(I)
temp_img=imresize(I,0.1);
EyeDetect = vision.CascadeObjectDetector('LeftEye');
BB=step(EyeDetect,temp_img);
figure,imshow(I);
rectangle('Position',BB(1,:)*10,'LineWidth',4,'LineStyle','-','EdgeColor','b');
rectangle('Position',BB(2,:)*10,'LineWidth',4,'LineStyle','-','EdgeColor','b');
title('Eyes Detection');
left=[BB(1,1)*10+BB(1,3)*10/2,BB(1,2)*10+BB(1,4)*10/2];
right=[BB(2,1)*10+BB(2,3)*10/2,BB(2,2)*10+BB(2,4)*10/2];