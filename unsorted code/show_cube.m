function []=show_cube(sp)
figure;
hold on;
r_m=3;
[x,y,z]=sphere(30);
for i=1:7
X=x*r_m+sp(i,1);
Y=y*r_m+sp(i,2);
Z=z*r_m+sp(i,3);
mesh(X,Y,Z);
text(sp(i,1),sp(i,2),sp(i,3)+2*r_m, num2str(i));
end
for i=1:6
    X=[sp(i,1),sp(i+1,1)];
    Y=[sp(i,2),sp(i+1,2)];
    Z=[sp(i,3),sp(i+1,3)];
    plot3(X,Y,Z,'--r');
end
X=[sp(1,1),sp(4,1)];
Y=[sp(1,2),sp(4,2)];
Z=[sp(1,3),sp(4,3)];
plot3(X,Y,Z,'--r');
X=[sp(1,1),sp(6,1)];
Y=[sp(1,2),sp(6,2)];
Z=[sp(1,3),sp(6,3)];
plot3(X,Y,Z,'--r');
X=[sp(2,1),sp(7,1)];
Y=[sp(2,2),sp(7,2)];
Z=[sp(2,3),sp(7,3)];
plot3(X,Y,Z,'--r');

mean_H=(norm(sp(4,:)-sp(5,:))+...
    norm(sp(1,:)-sp(6,:))+...
    norm(sp(2,:)-sp(7,:)))/3
mean_L=(norm(sp(1,:)-sp(2,:))+...
    norm(sp(3,:)-sp(4,:))+...
    norm(sp(6,:)-sp(7,:)))/3
mean_W=(norm(sp(4,:)-sp(1,:))+...
    norm(sp(3,:)-sp(2,:))+...
    norm(sp(5,:)-sp(6,:)))/3
grid on;
xlabel('x'),ylabel('y'),zlabel('z');
axis equal;
hold off;
