clear all
clc
ia=imread('calib.png');
image(ia)

grand_X=[0 1 1 1;  0 1 2 1;  1 0 2 1; 1 0 1 1;  0 2 1 1; 0 3 1 1];
petit_x=[781 565 ; 784 521 ; 705 519; 709 566 ; 821 588; 860 608 ];
p_x=petit_x';
g_X=grand_X';
P=getP(p_x,g_X);

%Verification

E=0;
h=size(g_X,2);


for i=1:h 
    x_projected=P*g_X(:,i);
    x_projected=x_projected/x_projected(3,1);
    E=(E+norm(x_projected(1:2,1)-p_x(:,i)))*1/h;
    
end

E

