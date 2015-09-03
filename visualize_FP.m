close all;
img_show=img_user;
H1=figure;
imagesc(D);
H2=figure;
imshow(aligned_img);
nPoints=2;
[x,y]=ginput(nPoints);
close all;
%%
load mat/platform_calib.mat
scale=100.3841/norm(median_transL-median_transR);
pro=uint8(zeros(size(img_show)));
com=img_show;
for img_user=x(1):6:x(2)
    for j=y(1):6:y(2)
        
        depth=D(round(j),round(img_user));
        if depth == Inf
            continue;
        end
        xx=depth/568.99*(img_user-643.21055941);%params.CameraParameters1.PrincipalPoint(1));
        yy=depth/568.99*(j-477.982801038);%params.CameraParameters1.PrincipalPoint(2));
        sp=[xx,yy,depth];
        sp_c=median_rotL^-1*sp'+scale*median_transL';
        r_eyeball=7.8;
        Reflection_R=solve_equation(Updated_CorneaCenter_R',sp_c',r_eyeball);
        Reflection_L=solve_equation(Updated_CorneaCenter_L',sp_c',r_eyeball);
        pointR=[fc(1)*Reflection_R(1)/Reflection_R(3)+cc(1),fc(2)*Reflection_R(2)/Reflection_R(3)+cc(2)];
        pointL=[fc(1)*Reflection_L(1)/Reflection_L(3)+cc(1),fc(2)*Reflection_L(2)/Reflection_L(3)+cc(2)];
        pro(round(pointR(2)),round(pointR(1)),:)=aligned_img(round(j),round(img_user),:);
        pro(round(pointL(2)),round(pointL(1)),:)=aligned_img(round(j),round(img_user),:);
    end
end
%%
figure;
crop1=imcrop(com,[para_irisR(1)-200,para_irisR(2)-150,400,300]);
crop2=imcrop(pro,[para_irisR(1)-200,para_irisR(2)-150,400,300]);
[crop_r,crop_c]=size(crop2);
crop_c = crop_c/3;
for img_user=1:crop_r
    for j=1:crop_c
        if sum(crop2(img_user,j,:)) ~= 0           
            crop1(img_user,j,:) = [255,255,255];
            for k=fliplr(1:crop_c)
                if sum(crop2(img_user,k,:)) ~= 0
                    crop1(img_user,k,:) = [255,255,255];
                    break;
                end
            end
            break;
        end
    end
end

crop3=imcrop(com,[para_irisL(1)-200,para_irisL(2)-150,400,300]);
crop4=imcrop(pro,[para_irisL(1)-200,para_irisL(2)-150,400,300]);
for img_user=1:crop_r
    for j=1:crop_c
        if sum(crop4(img_user,j,:)) ~= 0           
            crop3(img_user,j,:) = [255,255,255];
            for k=fliplr(1:crop_c)
                if sum(crop4(img_user,k,:)) ~= 0
                    crop3(img_user,k,:) = [255,255,255];
                    break;
                end
            end
            break;
        end
    end
end

imshow([crop1 crop2;crop3 crop4]);
hold off;