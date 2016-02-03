clear all
clc
ia=imread('calib.png');
image(ia)

grand_X=[0 1 1 1;  0 1 2 1;  1 0 2 1; 1 0 1 1;  0 2 1 1; 0 3 1 1];
petit_x=[781 565 ; 784 521 ; 705 519; 709 566 ; 821 588; 860 608 ];
p_x=petit_x';
g_X=grand_X';


petit_x2=[751 665 ; 78 21 ; 765 589; 705 166 ; 621 578; 850 608 ];
p_x2=petit_x2';
H=getH_Homo(p_x,p_x2);

H=[H' 1];
H = reshape(H, 3, 3)';
%Verification
P=getP(p_x,g_X);

[R,K] = qr(P);
E=0;
h=size(g_X,2);


for i=1:h 
    x_projected=P*g_X(:,i);
    x_projected=x_projected/x_projected(3,1);
    E=(E+norm(x_projected(1:2,1)-p_x(:,i)))*1/h;
    
end

E

