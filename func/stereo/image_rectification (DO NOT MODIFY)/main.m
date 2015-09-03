img1=imread('imagesU/data_R_0.png');
img2=imread('imagesU/data_R_1.png');
[row,col]=size(img1);
col=col/3;
crop_img1=img1(row/2-960/2:row/2+960/2-1,col/2-1280/2:col/2+1280/2-1,:);
crop_img2=img2(row/2-960/2:row/2+960/2-1,col/2-1280/2:col/2+1280/2-1,:);
imwrite(crop_img1,'imagesU/test_L.bmp','bmp');
imwrite(crop_img2,'imagesU/test_R.bmp','bmp');