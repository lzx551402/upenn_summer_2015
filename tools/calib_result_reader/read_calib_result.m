clear
clc

fid = fopen('camera2.txt');
p=0;
index=[];
trans=[];
rotate1=[];
rotate2=[];
rotate3=[];
i=0;
tline = fgetl(fid);
disp(tline);
tline = fgetl(fid);
S = regexp(tline, ' ', 'split');
c = char(S);
Num = str2num(c(2,:));
disp(tline);
tline = fgetl(fid);
disp(tline);
while 1
    tline = fgetl(fid);
    if ~ischar(tline)
        break;
    end
    S = regexp(tline, ' ', 'split');
    c = char(S);
    switch mod(i,5)
        case 0
            index=[index;str2num(c(2,:))];
        case 1
            temp(1)=str2double(c(1,:));
            temp(2)=str2double(c(2,:));
            temp(3)=str2double(c(3,:));
            trans=[trans;temp];
        case 2
            temp(1)=str2double(c(1,:));
            temp(2)=str2double(c(2,:));
            temp(3)=str2double(c(3,:));
            rotate1=[rotate1;temp];
        case 3
            temp(1)=str2double(c(1,:));
            temp(2)=str2double(c(2,:));
            temp(3)=str2double(c(3,:));
            rotate2=[rotate2;temp];
        case 4
            temp(1)=str2double(c(1,:));
            temp(2)=str2double(c(2,:));
            temp(3)=str2double(c(3,:));
            rotate3=[rotate3;temp];
        otherwise
            break;
    end
    i=i+1;
end
fclose(fid);
dis=zeros(Num/3,3);
for start = 0:Num/3-1
    i=find(index==start);
    if isempty(i)
        continue;
    end
    Tl=trans(i,:);
    Rl=[rotate1(i,:);
        rotate2(i,:);
        rotate3(i,:)];
    i=find(index==start+Num/3);
    if isempty(i)
        continue;
    end
    Tr=trans(i,:);
    Rr=[rotate1(i,:);
        rotate2(i,:);
        rotate3(i,:)];
    i=find(index==start+Num/3*2);
    if isempty(i)
        continue;
    end
    Tu=trans(i,:);
    Ru=[rotate1(i,:);
        rotate2(i,:);
        rotate3(i,:)];
    transTEST(start+1,:)=Rl*(Tr-Tl)';
    transL(start+1,:)=Ru*(Tl-Tu)';
    transR(start+1,:)=Ru*(Tr-Tu)';
    rotL(start+1,:)=real(vrrotmat2vec(Rl*Ru^-1));
    rotR(start+1,:)=real(vrrotmat2vec(Rr*Ru^-1));
end

%%
index=find(sum(transL,2)==0);
transL(index,:)=[];
para=mean(transL);
para_new=geometric_median(para,transL);
while norm(para-para_new)>0.00005
    para=para_new;
    para_new=geometric_median(para,transL);
end
median_transL=para_new;

transR(index,:)=[];
para=mean(transR);
para_new=geometric_median(para,transR);
while norm(para-para_new)>0.00005
    para=para_new;
    para_new=geometric_median(para,transR);
end
median_transR=para_new;

rotR(index,:)=[];
para=mean(rotR);
para_new=geometric_median(para,rotR);
while norm(para-para_new)>0.00005
    para=para_new;
    para_new=geometric_median(para,rotR);
end
median_rotR=vrrotvec2mat(para_new);

rotL(index,:)=[];
para=mean(rotL);
para_original=para;
para_new=geometric_median(para,rotL);
while norm(para-para_new)>0.00005
    para=para_new;
    para_new=geometric_median(para,rotL);
end
median_rotL=vrrotvec2mat(para_new);
close all;
Xr=median_rotR^-1*[0.5;0;0]+median_transR';
Yr=median_rotR^-1*[0;0.5;0]+median_transR';
Zr=median_rotR^-1*[0;0;0.5]+median_transR';
comb1=[median_transR' Xr];
comb2=[median_transR' Yr];
comb3=[median_transR' Zr];
figure;
axis equal;
line(comb1(1,:),comb1(2,:),comb1(3,:));
line(comb2(1,:),comb2(2,:),comb2(3,:));
line(comb3(1,:),comb3(2,:),comb3(3,:),'Color',[1 0 0]);
text(comb1(1,1),comb1(2,1),comb1(3,1),'right');
hold on;

Xu=[0.5;0;0];
Yu=[0;0.5;0];
Zu=[0;0;0.5];
comb1=[[0;0;0] Xu];
comb2=[[0;0;0] Yu];
comb3=[[0;0;0] Zu];
line(comb1(1,:),comb1(2,:),comb1(3,:));
line(comb2(1,:),comb2(2,:),comb2(3,:));
line(comb3(1,:),comb3(2,:),comb3(3,:),'Color',[1 0 0]);
text(comb1(1,1),comb1(2,1),comb1(3,1),'user');

Xl=median_rotL^-1*[0.5;0;0]+median_transL';
Yl=median_rotL^-1*[0;0.5;0]+median_transL';
Zl=median_rotL^-1*[0;0;0.5]+median_transL';
comb1=[median_transL' Xl];
comb2=[median_transL' Yl];
comb3=[median_transL' Zl];
grid on;
line(comb1(1,:),comb1(2,:),comb1(3,:));
line(comb2(1,:),comb2(2,:),comb2(3,:));
line(comb3(1,:),comb3(2,:),comb3(3,:),'Color',[1 0 0]);
text(comb1(1,1),comb1(2,1),comb1(3,1),'left');

save mat/platform_calib.mat median_rotR median_rotL median_transR median_transL
