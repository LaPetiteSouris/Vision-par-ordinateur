%%This is to caliberate camera and find K instrinsic matrix
%% To test the result, we calculate error E and reproject a 3D cube on the image



%Load image
clear all
clc
ia=imread('check.jpg');
imshow(ia)
grand_X=[0 0 0 1;     1 0 0 1;     1 1 0 1;    3 2 0 1;    2 0 1 1;     1 0 3 1];
petit_x=[1703 1506 ; 1491 1542 ;  1575 1722;   1167 2058 ; 1283 1422;   1627 946 ];
format long g

p_x=petit_x';
g_X=grand_X';
%Calucate P
P=getP(p_x,g_X);
%Decompose to get K

[K,R]=rq(P(:,1:3));
T = diag(sign(diag(K)));
K=K*T;
K = 1/K( 3 , 3 )*K( 1 : 3 , 1 : 3 )

E=0;
h=size(g_X,2);

%Estimation Error
for i=1:h
    x_projected=P*g_X(:,i);
    x_projected=x_projected/x_projected(3,1);
    E=(E+norm(x_projected(1:2,1)-p_x(:,i)))*1/h;
    
end

E;


%Re project cube on image to test


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

