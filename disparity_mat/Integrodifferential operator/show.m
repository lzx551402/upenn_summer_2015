function []=show(sp,r)
figure;
[N,~]=size(sp);
hold on;
r_m=r;
[x,y,z]=sphere(30);
for i=1:N
    X=x*r_m+sp(i,1);
    Y=y*r_m+sp(i,2);
    Z=z*r_m+sp(i,3);
    mesh(X,Y,Z);
    text(sp(i,1),sp(i,2),sp(i,3)+2*r_m, num2str(i));
end
for j=1:N-1
    for i=j:N-1
        
        X=[sp(j,1),sp(i+1,1)];
        Y=[sp(j,2),sp(i+1,2)];
        Z=[sp(j,3),sp(i+1,3)];
        plot3(X,Y,Z,'--r');
    end
end

grid on;
xlabel('x'),ylabel('y'),zlabel('z');
axis equal;
hold off;
