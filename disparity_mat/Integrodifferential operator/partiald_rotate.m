%function to find the partial derivative
%calculates the partial derivative of the normailzed line integral
%holding the centre coordinates constant
%and then smooths it by a gaussian of appropriate sigma 
%%rmin and rmax are the minimum and maximum values of radii expected
%function also returns the maximum value of blur and the corresponding radius
%It also returns the finite differnce vector blur
%INPUTS:
%I;input image
%C:centre coordinates
%rmin,rmax:minimum and maximum radius values
%n:number of sides of the polygon(for lineint)
%part:specifies whether it is searching for the iris or pupil
%sigma:standard deviation of the gaussian
%OUTPUTS:
%blur:the finite differences vector
%r:radius at maximum value of 'blur'
%b:maximum value of 'blur'

function [b,rmax_out,rmin_out,phi_out]=partiald_rotate(I,C,pre_rmax,pre_rmin,n)
rmax=pre_rmax-5:pre_rmax+5;
count=size(rmax,2);
rmin_vector=zeros(1,count);
b_vector=zeros(1,count);
phi_vector=zeros(1,count);
for k=1:count
    rmin=pre_rmin-5:rmax(k);
    dis=size(rmin,2);
    L_vector=zeros(1,dis);
    phi_t=zeros(1,dis);
    for j=1:length(rmin)
        [L_vector(j),phi_t(j)]=lineint_rotate(I,C,rmax(k),rmin(j),n);
        if L_vector(j)==0%if L(k)==0(this case occurs iff the radius takes the ellipse out of the image)
            %In this case,L is deleted as shown below and no more radii are taken for computation
            %(for that particular centre point).This is accomplished using the break statement
             L_vector(j)=[];
            break;
        end
    end
    D=diff(L_vector);
    D=[0 D];
    f=fspecial('gaussian',[1,5],0.5);%generat?es a 5 member 1-D gaussian
    %f=ones(1,7)/7;
    blur=convn(D,f,'same');%Smooths the D vecor by 1-D convolution 
    %'same' indicates that size(blur) equals size(D)
    blur=abs(blur);
    [b_vector(k),i]=max(blur);
    rmin_vector(k)=rmin(i);
    phi_vector(k)=phi_t(i);
end
[b,i]=max(b_vector);
rmax_out=rmax(i);
rmin_out=rmin_vector(i);
phi_out=phi_vector(i);
