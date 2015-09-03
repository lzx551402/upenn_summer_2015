%function to search for the centre coordinates of the pupil and the iris
%along with their major and minor radii
%Once the iris has been detected(using Daugman's method);the pupil's centre coordinates
%are found by searching a 10*10 neighbourhood around the iris centre and varying the radius
%until a maximum is found(using  Daugman's integrodifferential operator)
%INPUTS:
%I:image to be segmented
%rmin, rmax:the minimum and maximum values of the iris radius
%OUTPUTS:
%cp:the parametrs[xc,yc,r] of the pupilary boundary
%ci:the parametrs[xc,yc,r] of the limbic boundary
%out:the segmented image

function [ci]=thresh(I,rmin,rmax,cx,cy)
I=im2double(I);
range=10;
%arithmetic operations are not defined on uint8
%hence the image is converted to double
I=imcomplement(imfill(imcomplement(I),'holes'));
%this process removes specular reflections by using the morphological operation 'imfill'
rows=size(I,1);
cols=size(I,2);
m_b=zeros(rows,cols);
m_rmax=zeros(rows,cols);
m_rmin=zeros(rows,cols);
%defines two arrays maxb, maxrmax and maxrmin to store the maximum value of blur
%for each of the selected centre points and the corresponding radius
X=cx-range:cx+range;
Y=cy-range:cy+range;
for i=1:(range*2+1)
    for j=1:(range*2+1)
        [b,rmax_out,rmin_out]=partiald(I,[X(i),Y(j)],rmin,rmax,300);%coarse search
        m_b(X(i),Y(j))=b;
        m_rmax(X(i),Y(j))=rmax_out;
        m_rmin(X(i),Y(j))=rmin_out;
    end
end
[x,y]=find(m_b==max(max(m_b)));
rmax=m_rmax(x,y);
rmin=m_rmin(x,y);
%rmax=rmax+3;



ci=search(I,rmax,rmin,x,y);%fine search
[~,phi_out]=lineint_rotate(I,[ci(1),ci(2)],ci(3),ci(4),300);
ci=[ci(1),ci(2),ci(3),ci(4),phi_out];
%finds the maximum value of blur by scanning all the centre coordinates
%displaying the segmented image

