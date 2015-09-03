function F = bundle_adjustment2(para,gtL,gtR,sp_v,intrinsic_para)
%%L~1,R~2
p1_hat=gtL(:,1);
q1_hat=gtL(:,2);
p2_hat=gtR(:,1);
q2_hat=gtR(:,2);

r=7.8;
cx=intrinsic_para(3);
cy=intrinsic_para(4);
fx=intrinsic_para(1);
fy=intrinsic_para(2);
[M,~]=size(sp_v);
%%
for i=1:M
    R1=solve_equation([para(1,1),para(1,2),para(1,3)],...
    [sp_v(i,1),sp_v(i,2),sp_v(i,3)],r);
    X1(i)=R1(1);
    Y1(i)=R1(2);
    Z1(i)=R1(3);

    R2=solve_equation([para(2,1),para(2,2),para(2,3)],...
    [sp_v(i,1),sp_v(i,2),sp_v(i,3)],r);
    X2(i)=R2(1);
    Y2(i)=R2(2);
    Z2(i)=R2(3);
end
%%
N=1:M;
p1=fx*X1(N)./Z1(N)+cx;
q1=fy*Y1(N)./Z1(N)+cy;
p2=fx*X2(N)./Z2(N)+cx;
q2=fy*Y2(N)./Z2(N)+cy;
%%
temp=[p1'-p1_hat,q1'-q1_hat];
temp_M=temp*temp';
F=trace(temp_M);
temp=[p2'-p2_hat,q2'-q2_hat];
temp_M=temp*temp';

F=F+trace(temp_M);
F=F/max(N)/2;