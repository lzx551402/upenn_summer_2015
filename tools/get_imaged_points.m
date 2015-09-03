function P=get_imaged_points(img,center,win_size,n)
if center == 0
    imshow(img);
    [x,y] = ginput(n);
    close all;
    P=[x y];
else
    crop_img=img(center(1)-win_size:center(1)+win_size,...
                 center(2)-win_size:center(2)+win_size,:);
    imshow(crop_img);
    offsetX=center(2)-win_size;
    offsetY=center(1)-win_size;
    [x,y] = ginput(n);
    close all;
    x=x+offsetX;
    y=y+offsetY;
    P=[x y];
end