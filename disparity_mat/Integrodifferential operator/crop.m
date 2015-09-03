function crop_img=crop(img,x,y,win_size)
crop_img=img([x-win_size:x+win_size],[y-win_size:y+win_size],:);