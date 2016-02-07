clear all
clc
ia=imread('check.jpg');
% imshow(ia)
grand_X=[0 0 0 1;     1 0 0 1;     1 1 0 1;    3 2 0 1;    2 0 1 1;     1 0 3 1];
petit_x=[1703 1506 ; 1491 1542 ;  1575 1722;   1167 2058 ; 1283 1422;   1627 946 ];
p_x=petit_x';
g_X=grand_X';

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


[R,K] = qr(P);


% 
% figure, imshow(ia), hold on, title('Detected features frame 2');
% plot(proj(:,1),proj(:,2),'go')

