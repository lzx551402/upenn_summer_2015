%function to detect the pupil boundary
%it searches a certain subset of the image
%with a given radius
%around a 10*10 neighbourhood of the point cx,cy given as input
%INPUTS:
%I:image to be processed
%rmin:minimum radius
%rmax:maximum radius
%cx:x-coordinate of centre point
%cy:y-coordinate of centre point
%OUTPUT:
%ci:[cx,cy,rmax,rmin,phi]

function [ci]=search(I,rmax,rmin,cx,cy)
rows=size(I,1);
cols=size(I,2);
range=5;
m_rmax=zeros(rows,cols);
m_rmin=zeros(rows,cols);
m_phi=zeros(rows,cols);
m_b=zeros(rows,cols);
for i=(cx-range):(cx+range)
    for j=(cy-range):(cy+range)
        tic
        [b,rmax_out,rmin_out,phi_out]=partiald_rotate(I,[i,j],rmax,rmin,300);
        toc
        m_rmax(i,j)=rmax_out;
        m_rmin(i,j)=rmin_out;
        m_b(i,j)=b;
        m_phi(i,j)=phi_out;
    end
end
[x,y]=find(m_b==max(max(m_b)));
rmax=m_rmax(x,y);
rmin=m_rmin(x,y);
phi=m_phi(x,y);
ci=[cx,cy,rmax,rmin,phi];



        