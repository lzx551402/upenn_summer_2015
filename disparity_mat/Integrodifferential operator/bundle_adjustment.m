function F = bundle_adjustment(para,gtL,gtR,intrinsic_para)
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
[M,~]=size(para);
%%
for i=1:M-2
    R1=solve_equation([para(M-1,1),para(M-1,2),para(M-1,3)],...
    [para(i,1),para(i,2),para(i,3)],r);
    X1(i)=R1(1);
    Y1(i)=R1(2);
    Z1(i)=R1(3);

    R2=solve_equation([para(M,1),para(M,2),para(M,3)],...
    [para(i,1),para(i,2),para(i,3)],r);
    X2(i)=R2(1);
    Y2(i)=R2(2);
    Z2(i)=R2(3);
end
%%
N=1:M-2;
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