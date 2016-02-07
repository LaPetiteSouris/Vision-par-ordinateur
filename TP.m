clear all
clc
ia=imread('check.jpg');
imshow(ia)

% grand_X=[0 0 0 1;  0 1 0 1;  0 1 1 1; 0 0 1 1;  1 0 1 1; 1 0 0 1; 1 1 0 1  ;   1 1 1 1];
m = [   750 592 ;
      737 773   ;
      571 471    ;
      913 473   ;
      701 645   ;
      1081  413 ];


M = [0 0 0 1;
     4 4 0 1;
     4 0 4 1;
     0 4 4 1;
     2 1 0 1;
     0 7 6 1];
petit_x=[745 589 ; 783 608 ; 784 573; 749 550 ; 714 571; 710 611 ; 742 630;   747 583];
p_x=m';
g_X=M';
% 
% 
% petit_x2=[751 665 ; 78 21 ; 765 589; 705 166 ; 621 578; 850 608 ];
% p_x2=petit_x2';
% H=getH_Homo(p_x,p_x2);
% 
% H=[H' 1];
% H = reshape(H, 3, 3)';
% %Verification
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

c=[0 0 0 1; 0 1 0 1;   1 1 0 1; 1 0 0 1;  1 0 1 1; 0 0 1 1; 0 1 1 1; 1 1 1 1;1 0 1 1; 0 0 1 1; 0 0 0 1;
    1 0 0 1 ; 1 1 0 1; 0 1 0 1;0 1 1 1 ;1 1 1 1;1 1 0 1];
c=c';
est=P*c;
h=size(c,2);

for i=1:h
    for k=1:3
    est(k,i)=est(k,i)/est(3,i);
    end
    
end

est=est';
% 
figure, imshow(ia), hold on, title('Detected features frame 2');
plot(est(:,1),est(:,2),'r')

