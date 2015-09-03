%%
pR=[2546 1151];
pR=[pR 1];
sR=intrinsic_matrix^-1*pR';
sR=20*sR/norm(sR);
SR=solve_equation(mirrorCenterR,sR',r_eyeball);
VrR=-SR/norm(SR);
NR=SR-mirrorCenterR;
NR=NR/norm(NR);
ViR=VrR-2*NR*(NR*VrR');

pL=[1455 1231];
pL=[pL 1];
sL=intrinsic_matrix^-1*pL';
sL=20*sL/norm(sL);
SL=solve_equation(mirrorCenterL,sL',r_eyeball);
VrL=-SL/norm(SL);
NL=SL-mirrorCenterL;
NL=NL/norm(NL);
ViL=VrL-2*NL*(NL*VrL');
%%
offset=[0.17 0.37 5.4];
NewmirrorCenterL=mirrorCenterL+offset;
NewmirrorCenterR=mirrorCenterR+offset;
N=cross(ViR,ViL);
dis=(NewmirrorCenterR-NewmirrorCenterL)*N'/norm(N);
tR=cross((NewmirrorCenterL-NewmirrorCenterR),ViL)*N'/norm(N)^2;
tL=cross((NewmirrorCenterL-NewmirrorCenterR),ViR)*N'/norm(N)^2;
spR=NewmirrorCenterR+tR*ViR;
spL=NewmirrorCenterL+tL*ViL;
sp=(spR+spL)/2;

R_R_re=solve_equation(mirrorCenterR,sp,r_eyeball);
pointR=[fc(1)*R_R_re(1)/R_R_re(3)+cc(1),fc(2)*R_R_re(2)/R_R_re(3)+cc(2)];
R_L_re=solve_equation(mirrorCenterL,sp,r_eyeball);
pointL=[fc(1)*R_L_re(1)/R_L_re(3)+cc(1),fc(2)*R_L_re(2)/R_L_re(3)+cc(2)];
close all;
img=imread('img/data/80.JPG');
img(pR(2),pR(1),:)=[255;255;255];
img(pL(2),pL(1),:)=[255;255;255];
img(round(pointR(2)),round(pointR(1)),:)=[255;0;0];
img(round(pointL(2)),round(pointL(1)),:)=[255;0;0];
img_R=img(pR(2)-50:pR(2)+50,pR(1)-50:pR(1)+50,:);
img_L=img(pL(2)-50:pL(2)+50,pL(1)-50:pL(1)+50,:);
figure;
img_com=[img_L img_R];
imshow(img_com);