function [para_iris]=ellipse_params(I,point)
addpath(genpath(pwd));
init=point;
P=get_imaged_points(I,[init(2) init(1)],200,10);
para_iris=EllipseDirectFit(P);