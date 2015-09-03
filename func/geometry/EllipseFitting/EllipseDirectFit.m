function para = EllipseDirectFit(XY)
%
%  Direct ellipse fit, proposed in article
%    A. W. Fitzgibbon, M. Pilu, R. B. Fisher
%     "Direct Least Squares Fitting of Ellipses"
%     IEEE Trans. PAMI, Vol. 21, pages 476-480 (1999)
%
%  Our code is based on a numerically stable version
%  of this fit published by R. Halir and J. Flusser
%
%     Input:  XY(n,2) is the array of coordinates of n points x(i)=XY(i,1), y(i)=XY(i,2)
%
%     Output: A = [a b c d e f]' is the vector of algebraic 
%             parameters of the fitting ellipse:
%             ax^2 + bxy + cy^2 +dx + ey + f = 0
%             the vector A is normed, so that ||A||=1
%
%  This is a fast non-iterative ellipse fit.
%
%  It returns ellipses only, even if points are
%  better approximated by a hyperbola.
%  It is somewhat biased toward smaller ellipses.
%
centroid = mean(XY);   % the centroid of the data set

D1 = [(XY(:,1)-centroid(1)).^2, (XY(:,1)-centroid(1)).*(XY(:,2)-centroid(2)),...
      (XY(:,2)-centroid(2)).^2];
D2 = [XY(:,1)-centroid(1), XY(:,2)-centroid(2), ones(size(XY,1),1)];
S1 = D1'*D1;
S2 = D1'*D2;
S3 = D2'*D2;
T = -inv(S3)*S2';
M = S1 + S2*T;
M = [M(3,:)./2; -M(2,:); M(1,:)./2];
[evec,eval] = eig(M);
cond = 4*evec(1,:).*evec(3,:)-evec(2,:).^2;
A1 = evec(:,find(cond>0));
A = [A1; T*A1];
A4 = A(4)-2*A(1)*centroid(1)-A(2)*centroid(2);
A5 = A(5)-2*A(3)*centroid(2)-A(2)*centroid(1);
A6 = A(6)+A(1)*centroid(1)^2+A(3)*centroid(2)^2+...
     A(2)*centroid(1)*centroid(2)-A(4)*centroid(1)-A(5)*centroid(2);
A(4) = A4;  A(5) = A5;  A(6) = A6;
%convert vector A to the geometric parameters (semi-axes, center, etc.) 
%use standard formulas in Wolfram Mathworld: 
para=zeros(1,5);
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
%adjust the params to eye model
if para(4)>para(3)
    t=para(4);
    para(4)=para(3);
    para(3)=t;
    para(5)=para(5)-pi/2;
end

