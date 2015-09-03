function [I,Ci,Ce,gaze]=gaze_estimation(I,para_iris,fc,cc,flag)
%%
if para_iris(4)<para_iris(3)
    theta=flag*acos(para_iris(4)/para_iris(3));
else
    theta=flag*acos(para_iris(3)/para_iris(4));
end
phi=para_iris(5);
if phi < 0
    phi=pi+phi;
end

z=5.6*(fc(1)+fc(2))/2/para_iris(3);
x=z*(para_iris(1)-cc(1))/fc(1);
y=z*(para_iris(2)-cc(2))/fc(2);
Ci=[x,y,z,phi,theta];
gaze=[sin(theta)*sin(phi);-sin(theta)*cos(phi);-cos(theta)];
Ce=[Ci(1);Ci(2);Ci(3)]-5.6*gaze;
project_p=[fc(1)*Ce(1)/Ce(3)+cc(1),fc(2)*Ce(2)/Ce(3)+cc(2)];
%%
%visualization
temp=I;
K=-[project_p(2),project_p(1)]+[para_iris(2),para_iris(1)];
K=K/norm(K);
for i=1:150
    XY=i*K+[project_p(2) project_p(1)];
    %temp(round(XY(1)),round(XY(2)),:)=[128;128;0];
end
%temp(round(project_p(2)),round(project_p(1)),:)=[0;255;0];
temp(round(para_iris(2)),round(para_iris(1)),:)=[255;0;0];

theta=(2*pi)/600;
angle=theta:theta:2*pi;

y=para_iris(3)*cos(angle)*cos(para_iris(5))-para_iris(4)*sin(angle)*sin(para_iris(5))+para_iris(1);
x=para_iris(3)*cos(angle)*sin(para_iris(5))+para_iris(4)*sin(angle)*cos(para_iris(5))+para_iris(2);

plot(x,y);
for i=1:600
    temp(round(x(i)),round(y(i)),:)=[255;255;255];
end

I=temp;