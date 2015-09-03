%%
clear
clc
close all
load('calibration.mat');
raw=imread('img/raw7.JPG');
raw=rgb2gray(raw);

[ciL,ciR]=main(raw,[90, 110, 1016,1070],[90,110,2135,1010]);

intrinsic_matrix=[fc(1) 0 cc(1);
    0 fc(2) cc(2);
    0 0 1];
[paraL,paraR]=postProsessing(ciL,ciR,fc,cc);
%%
offset=[-0.05 -0.55 1.1];
mirrorCenterR=[paraR(1) paraR(2) paraR(3)]+offset;
mirrorCenterL=[paraL(1) paraL(2) paraL(3)]+offset;
close all;
r_eyeball = 7.8;
flag=1;
gtR=[2148,1035];
gtL=[1033,1100];
err=0.5;
range=150;
for x=-range:0.5:range
    if flag == 1
        for y=-range:0.5:range
            P=[x y 10];
            R_R=solve_equation(mirrorCenterR,P,r_eyeball);
            pointR=[fc(1)*R_R(1)/R_R(3)+cc(1),fc(2)*R_R(2)/R_R(3)+cc(2)];
            if pointR(1)>=(gtR(1)-err) && pointR(1)<=(gtR(1)+err)
                if pointR(2)>=(gtR(2)-err) && pointR(2)<=(gtR(2)+err)
                    disp( sprintf( 'finish!') )
                    flag=0;
                    break;
                end
            end
        end
    
    end
end
        %R_L=solve_equation(mirrorCenterL,P,r_eyeball);
        %pointL=[fc(1)*R_L(1)/R_L(3)+cc(1),fc(2)*R_L(2)/R_L(3)+cc(2)];

%draw epipolar curve
P_vector=[];
R_vector=[];
point_vector=[];
P_min=700;
P_max=600;
delta=R_R-P;
for i=-P_min:P_max
    P_vector(i+P_min+1,:)=P+i*delta/norm(delta);
end

for i=-P_min:P_max
    R_vector(i+P_min+1,:)=solve_equation(mirrorCenterL,P_vector(i+P_min+1,:),r_eyeball);   
end

for i=-P_min:P_max
    point_vector(i+P_min+1,:)=[fc(1)*R_vector(i+P_min+1,1)/R_vector(i+P_min+1,3)+cc(1),fc(2)*R_vector(i+P_min+1,2)/R_vector(i+P_min+1,3)+cc(2)];
end
X=[];
Y=[];
X=point_vector(:,1);
Y=point_vector(:,2);

img=imread('img/raw7.JPG');
for i=-P_min:P_max
    img(round(Y(i+P_min+1)),round(X(i+P_min+1)),1)=255;
    img(round(Y(i+P_min+1)),round(X(i+P_min+1)),2)=255;
    img(round(Y(i+P_min+1)),round(X(i+P_min+1)),3)=255;
end
img(round(pointR(2)),round(pointR(1)),1)=255;
    img(round(pointR(2)),round(pointR(1)),2)=255;
    img(round(pointR(2)),round(pointR(1)),3)=255;
img_R=img(round(pointR(2))-50:round(pointR(2))+50,round(pointR(1))-50:round(pointR(1))+50,:);
X_max=max(X);
Y_max=max(Y);
X_min=min(X);
Y_min=min(Y);
Y_mean=Y_max/2+Y_min/2;

L_imgPoint=[X Y];
gtL_vector=repmat(gtL,P_max+P_min+1,1);
res=L_imgPoint-gtL_vector;
res=res.*res;
ress=sqrt(res(:,1)+res(:,2));
[min_dis,index]=min(ress);
min_dis
img(round(Y(index)),round(X(index)),1)=255;
img(round(Y(index)),round(X(index)),2)=0;
img(round(Y(index)),round(X(index)),3)=0;
img_L=img(round(Y_mean)-50:round(Y_mean)+50,round(X_min)-50:round(X_max)+50,:);

figure;
img_com=[img_L img_R];
P=P_vector(index,:)
imshow(img_com);
%%
r_m=1;
[x,y,z]=sphere(30);
%figure;
hold on;

axis equal;
for i=1:7
X=x*r_m+sceneP(i,1);
Y=y*r_m+sceneP(i,2);
Z=z*r_m+sceneP(i,3);
mesh(X,Y,Z);
text(sceneP(i,1),sceneP(i,2),sceneP(i,3)-10, num2str(i));
end
for i=1:6
    X=[sceneP(i,1),sceneP(i+1,1)];
    Y=[sceneP(i,2),sceneP(i+1,2)];
    Z=[sceneP(i,3),sceneP(i+1,3)];
    plot3(X,Y,Z,'--r');
end
X=[sceneP(1,1),sceneP(4,1)];
Y=[sceneP(1,2),sceneP(4,2)];
Z=[sceneP(1,3),sceneP(4,3)];
plot3(X,Y,Z,'--r');
X=[sceneP(1,1),sceneP(6,1)];
Y=[sceneP(1,2),sceneP(6,2)];
Z=[sceneP(1,3),sceneP(6,3)];
plot3(X,Y,Z,'--r');
X=[sceneP(2,1),sceneP(7,1)];
Y=[sceneP(2,2),sceneP(7,2)];
Z=[sceneP(2,3),sceneP(7,3)];
plot3(X,Y,Z,'--r');


grid on;
hold off;
mean_H=(norm(sceneP(4,:)-sceneP(5,:))+...
    norm(sceneP(1,:)-sceneP(6,:))+...
    norm(sceneP(2,:)-sceneP(7,:)))/3
mean_L=(norm(sceneP(1,:)-sceneP(2,:))+...
    norm(sceneP(3,:)-sceneP(4,:))+...
    norm(sceneP(6,:)-sceneP(7,:)))/3
mean_W=(norm(sceneP(4,:)-sceneP(1,:))+...
    norm(sceneP(3,:)-sceneP(2,:))+...
    norm(sceneP(5,:)-sceneP(6,:)))/3
xlabel('x'),ylabel('y'),zlabel('z');
%%
R_L=solve_equation(mirrorCenterL,sceneP(1,:),r_eyeball);
pointL=[fc(1)*R_L(1)/R_L(3)+cc(1),fc(2)*R_L(2)/R_L(3)+cc(2)];
%%
r_m=1;
[x,y,z]=sphere(30);
%eyeball L
X=x*r_eyeball+mirrorCenterL(1);
Y=y*r_eyeball+mirrorCenterL(2);
Z=z*r_eyeball+mirrorCenterL(3);
hold on;
mesh(X,Y,Z);

%reflection point L
X=x*r_m+R_L(1);
Y=y*r_m+R_L(2);
Z=z*r_m+R_L(3);
h=mesh(X,Y,Z);
set(h,'EdgeColor',[0 0 0])
text(R_L(1),R_L(2),R_L(3)-10, 'Right RP')
%eyeball R
X=x*r_eyeball+mirrorCenterR(1);
Y=y*r_eyeball+mirrorCenterR(2);
Z=z*r_eyeball+mirrorCenterR(3);
mesh(X,Y,Z);
%reflection point R
X=x*r_m+R_R(1);
Y=y*r_m+R_R(2);
Z=z*r_m+R_R(3);
h=mesh(X,Y,Z);
set(h,'EdgeColor',[0 0 0])
text(R_R(1),R_R(2),R_R(3)-10, 'Left RP')
%scene point
X=x*r_m+P(1);
Y=y*r_m+P(2);
Z=z*r_m+P(3);
mesh(X,Y,Z);
text(P(1),P(2),P(3), '   Scene Point')
%camera pupil
X=x*2*r_m;
Y=y*2*r_m;
Z=z*2*r_m;
mesh(X,Y,Z);
text(0,0,0, '   Camera Pupil')

%%image plane
test=imresize(raw,0.25);
fl=20;
scale=fl/(fc(1)+fc(2))*2*4;
gray=[];
gray=test(:,:,1);
C=[];
C(:,:,1)=gray;
%C(,2,:)=gray;
%C(:,:,3)=B;
s_img=size(test);
[X,Y]=meshgrid(1:s_img(2),1:s_img(1));
X=X-s_img(2)/2;
Y=Y-s_img(1)/2;
X=X*scale;
Y=Y*scale;

Z=ones(size(X))*fl;
mesh(X,Y,Z,C);

%draw line
X=[R_R(1) P(1)];
Y=[R_R(2) P(2)];
Z=[R_R(3) P(3)];
plot3(X,Y,Z,'--g');
X=[R_R(1) 0];
Y=[R_R(2) 0];
Z=[R_R(3) 0];
plot3(X,Y,Z,'--g');
X=[R_L(1) P(1)];
Y=[R_L(2) P(2)];
Z=[R_L(3) P(3)];
plot3(X,Y,Z,'--r');
X=[R_L(1) 0];
Y=[R_L(2) 0];
Z=[R_L(3) 0];
plot3(X,Y,Z,'--r');
%
xlabel('x'),ylabel('y'),zlabel('z');
axis equal;
hold off;
clear x;
clear y;
clear z;

%%
r_m=1;
[x,y,z]=sphere(30);
%eyeball L
X=x*r_eyeball+mirrorCenterL(1);
Y=y*r_eyeball+mirrorCenterL(2);
Z=z*r_eyeball+mirrorCenterL(3);
hold on;
mesh(X,Y,Z);
%eyeball R
X=x*r_eyeball+mirrorCenterR(1);
Y=y*r_eyeball+mirrorCenterR(2);
Z=z*r_eyeball+mirrorCenterR(3);
mesh(X,Y,Z);
%image plane
test=imresize(raw,0.25);
fl=20;
scale=fl/(fc(1)+fc(2))*2*4;
gray=[];
gray=test(:,:,1);
C=[];
C(:,:,1)=gray;

s_img=size(test);
[X,Y]=meshgrid(1:s_img(2),1:s_img(1));
X=X-s_img(2)/2;
Y=Y-s_img(1)/2;
X=X*scale;
Y=Y*scale;

Z=ones(size(X))*fl;
mesh(X,Y,Z,C);

%camera pupil
X=x*2*r_m;
Y=y*2*r_m;
Z=z*2*r_m;
mesh(X,Y,Z);
text(0,0,0, '   Camera Pupil')
xlabel('x'),ylabel('y'),zlabel('z');
axis equal;

clear x;
clear y;
clear z;
%



X=[-Vr(1)*200 0];
Y=[-Vr(2)*200 0];
Z=[-Vr(3)*200 0];
plot3(X,Y,Z,'--r');


X=[200*Vi(1) 0];
Y=[200*Vi(2) 0];
Z=[200*Vi(3) 0];
plot3(X,Y,Z,'--g');

hold off;