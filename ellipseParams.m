function [para_iris]=ellipseParams(I)
init=get_points(I,0,0,1);
P=get_points(I,[init(2) init(1)],200,10);
para_iris=ellipseFitting(P);
if para_iris(4)>para_iris(3)
    t=para_iris(4);
    para_iris(4)=para_iris(3);
    para_iris(3)=t;
    para_iris(5)=para_iris(5)-pi/2;
end