close all
intrinsic_matrix=[fc(1) 0 cc(1);
    0 fc(2) cc(2);
    0 0 1];
epipolar = I;
[n,~]=size(gtR2);
color=zeros(n,3);
LEFT=imread('bin/new2/u_new2_l.bmp');
for i=1:n
    clear sp_to_user
    i
    color(i,:)=round(rand(1,3)*255);
    pR=gtR2(i,:);
    m_mirrorCenterR=Updated_CorneaCenter_R';
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

    for j=1:5:5000
        j
        sp_to_user((j+4)/5,:) = SR+ViR*(7.8+j);
        Reflection_L=solve_equation(CorneaCenter_L',sp_to_user((j+4)/5,:),r_eyeball);
        pointL=[fc(1)*Reflection_L(1)/Reflection_L(3)+cc(1),fc(2)*Reflection_L(2)/Reflection_L(3)+cc(2)];
        epipolar(round(pointL(2)),round(pointL(1)),:)=color(i,:);
        if j>1000
            sp_to_left=median_rotL*(sp_to_user((j+4)/5,:,:)'-scale*median_transL');
                pointL=[568.996140852*sp_to_left(1)/sp_to_left(3)+643.21055941,...
                    568.988362396*sp_to_left(2)/sp_to_left(3)+477.982801038];
                if pointL(1)<0 | pointL(2)<0
                    continue;
                end
            LEFT(round(pointL(2)),round(pointL(1)),:)=color(i,:);
        end
    end
    epipolar(round(pR(2)),round(pR(1)),:)=color(i,:);
    
end
crop11=imcrop(epipolar,[para_irisL(1)-200,para_irisL(2)-150,400,300]);
crop22=imcrop(epipolar,[para_irisR(1)-200,para_irisR(2)-150,400,300]);
imshow([crop22,crop11]);
figure
imshow(LEFT)
