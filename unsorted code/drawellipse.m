function []=drawellipse(in,ciL)
figure;
imshow(in);
hL=ellipse(ciL(3),ciL(4),ciL(5),ciL(2),ciL(1),'r');
%hR=ellipse(ciR(3),ciR(4),ciR(5),ciR(2),ciR(1),'r');
x=get(hL,'Xdata');
y=get(hL,'Ydata');
%xR=get(hR,'Xdata');
%yR=get(hR,'Ydata');
%x=[xL xR];
%y=[yL yR];
for i=1:length(x) 
hold on; 
patch(x(i),y(i),'y'); 
hold off; 
end