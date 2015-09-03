function [para]=ellipseFitting(P)
para=zeros(1,5);
A = EllipseDirectFit(P);
a=A(1);
b=A(2)/2;
c=A(3);
d=A(4)/2;
f=A(5)/2;
g=A(6);
delta=b^2-a*c;
para(1)=(c*d-b*f)/delta;
para(2)=(a*f-b*d)/delta;
para(3)=sqrt(2*(a*f^2+c*d^2+g*b^2-2*b*d*f-a*c*g)/delta/(sqrt((a-c)^2+4*b^2)-(a+c)));
para(4)=sqrt(2*(a*f^2+c*d^2+g*b^2-2*b*d*f-a*c*g)/delta/(-sqrt((a-c)^2+4*b^2)-(a+c)));
if b==0
    if a<=c
        para(5)=0;
    else
        para(5)=1/2*pi;
    end
else
    if a<=c
        para(5)=1/2*acot((a-c)/2/b);
    else
        para(5)=pi/2+1/2*acot((a-c)/2/b);
    end
end