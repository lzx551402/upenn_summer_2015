function []=show_everything(sp,mirrorCenterR,mirrorCenterL,img,fc)
figure;
[x,y,z]=sphere(30);
r_m=5;
r_eyeball=7.8;
%camera pupil
X=x*2*r_m;
Y=y*2*r_m;
Z=z*2*r_m;
mesh(X,Y,Z);
text(0,0,0, '   Camera Pupil')
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
test=imresize(img,0.25);
fl=20;
scale=fl/(fc(1)+fc(2))*2*4;
C=[];
C(:,:,1)=test(:,:,1);

s_img=size(test);
[X,Y]=meshgrid(1:s_img(2),1:s_img(1));
X=X-s_img(2)/2;
Y=Y-s_img(1)/2;
X=X*scale;
Y=Y*scale;

Z=ones(size(X))*fl;
mesh(X,Y,Z,C);
%sp
[N,~]=size(sp);
hold on;
[x,y,z]=sphere(30);
for i=1:N
    X=x*r_m+sp(i,1);
    Y=y*r_m+sp(i,2);
    Z=z*r_m+sp(i,3);
    mesh(X,Y,Z);
    text(sp(i,1),sp(i,2),sp(i,3)+2*r_m, num2str(i));
end
for j=1:N-1
    for i=j:N-1
        
        X=[sp(j,1),sp(i+1,1)];
        Y=[sp(j,2),sp(i+1,2)];
        Z=[sp(j,3),sp(i+1,3)];
        plot3(X,Y,Z,'--r');
    end
end
line([0 200],[0 0],[0 0])
text(200,0,0, 'x');
line([0 0],[0 200],[0 0])
text(0,200,0, 'y');
line([0 0],[0 0],[0 200])
text(0,0,200, 'z');
view(30,10)
grid on;
xlabel('x'),ylabel('y'),zlabel('z');
axis equal;
hold off;
