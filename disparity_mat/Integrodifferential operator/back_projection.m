function [sp,dis]=back_projection(pR,pL,intrinsic_matrix,...
    m_mirrorCenterR,m_mirrorCenterL)
r_eyeball=7.8;
pR=[pR 1];
sR=intrinsic_matrix^-1*pR';
syms t
eq=(t*sR(1)-m_mirrorCenterR(1))^2+...
   (t*sR(2)-m_mirrorCenterR(2))^2+...
   (t*sR(3)-m_mirrorCenterR(3))^2-...
    r_eyeball^2;
[t]=solve(eq,'t');
t=eval(t);
t=min(t);
SR=t*sR';

VrR=-SR/norm(SR);
NR=SR-m_mirrorCenterR;
NR=NR/norm(NR);
ViR=2*(dot(NR,VrR)/dot(NR,NR))*NR-VrR;

pL=[pL 1];
sL=intrinsic_matrix^-1*pL';
syms t
eq=(t*sL(1)-m_mirrorCenterL(1))^2+...
   (t*sL(2)-m_mirrorCenterL(2))^2+...
   (t*sL(3)-m_mirrorCenterL(3))^2-...
    r_eyeball^2;
[t]=solve(eq,'t');
t=eval(t);
t=min(t);
SL=t*sL';

VrL=-SL/norm(SL);
NL=SL-m_mirrorCenterL;
NL=NL/norm(NL);
ViL=2*(dot(NL,VrL)/dot(NL,NL))*NL-VrL;

N=cross(ViR,ViL);
tR=cross((SL-SR),ViL)*N'/norm(N)^2;
tL=cross((SL-SR),ViR)*N'/norm(N)^2;
spR=SR+tR*ViR;
spL=SL+tL*ViL;
sp=(spR+spL)/2;

dis=norm(sp-spR);