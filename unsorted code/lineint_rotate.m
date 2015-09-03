%function to calculate the normalised line integral around a circular contour
%A polygon of large number of sides approximates a circle and hence is used
%here to calculate the line integral by summation
%INPUTS:
%1.I:Image to be processed
%2.C(x,y):Centre coordinates of the circumcircle
%Coordinate system :
%origin of coordinates is at the top left corner
%positive x axis points vertically down
%and positive y axis horizontally and to the right
%3.n:number of sides
%4.rmax:long axis of the ellipse (rmax)
%5.rmin:short axis of the ellipse (rmin)
%for the iris only the lateral portions are used to mitigate the effect of occlusions 
%that might occur at the top and/or at the bottom
%OUTPUT:
%L:the line integral divided by circumference
function [L_out,phi_out]=lineint_rotate(I,C,rmax,rmin,n)
theta=(2*pi)/n;% angle subtended at the centre by the sides
%orient one of the radii to lie along the y axis
%positive angle is ccw
if rmax==rmin
    phi_vector=0;
else
    phi_vector=-30:30;
end
length=size(phi_vector,2);
rows=size(I,1);
cols=size(I,2);
angle=theta:theta:2*pi;
L_vector=zeros(1,length);
for z=1:length
    y=rmax*cos(angle)*cos(phi_vector(z)/180*pi)-rmin*sin(angle)*sin(phi_vector(z)/180*pi)+C(2);
    x=rmax*cos(angle)*sin(phi_vector(z)/180*pi)+rmin*sin(angle)*cos(phi_vector(z)/180*pi)+C(1);
    if (any(x>rows)||any(y>cols)||any(x<1)||any(y<1))
        L_vector(z)=[];
        phi_vector(z)=[];
        continue;
    %This process returns L=0 for any circle that does not fit inside the image
    end
    %start to calculate the lineint
    s=0;
    for i=1:n%round((n/8))
      val=I(round(x(i)),round(y(i)));
      s=s+val;
    end
% 
%     for i=(round(3*n/8))+1:round((5*n/8))
%       val=I(round(x(i)),round(y(i)));
%       s=s+val;
%     end
%     
%     for i=round((7*n/8))+1:(n)
%       val=I(round(x(i)),round(y(i)));
%       s=s+val;
%     end
    L_vector(z)=(2*s)/n;
end   
    D=diff(L_vector);
    D=[0 D];
    %append one element at the beginning to make it an n vector
    %Partial derivative at rmin is assumed to be zero
    f=fspecial('gaussian',[1,5],0.5);%generates a 5 member 1-D gaussian
    blur=convn(D,f,'same');%Smooths the D vecor by 1-D convolution 
    %'same' indicates that size(blur) equals size(D)
    blur=abs(blur);
    [~,i]=max(blur);
    phi_out=phi_vector(i)/180*pi;
    L_out=L_vector(i);
end