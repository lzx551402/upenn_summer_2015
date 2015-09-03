function [R]=solve_equation(C,P,r)
z2=-C;
z1=P-C*(C*P')/norm(C)^2;
d=norm(z2);
u=norm(z1);
v=-C*(P-C)'/norm(C);

K1=[4*d^2,...
    -4*d*r^2,...
    r^4-4*d^2*r^2,...
    2*r^4*d,...
    r^4*d^2]*u^2;
K2=[-4*d^2*v^2,...
    4*d*v*r^2*(d+v),...
    -r^4*(d+v)^2+4*d^2*v^2*r^2,...
    -4*d*v*r^4*(d+v),...
    r^6*(d+v)^2];
K=K1-K2;

y=roots(K);

y=y(find( y>0 & y <= r+10^-6));
y=max(y);
x=sign(u)*sqrt((r+10^-6)^2-y^2);

if x==0
    R=C+y*z2/norm(z2);
else
    R=C+x*z1/norm(z1)+y*z2/norm(z2);
end