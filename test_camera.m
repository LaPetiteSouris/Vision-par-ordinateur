close all;
clear all;
v = VideoReader('o.ogv');
I= read(v,1);
I=rgb2gray(I);
points = detectHarrisFeatures(I);

figure, imshow(I), hold on, title('Detected features frame 1');
plot(points(15:23));
K = [ -1161         112        -484;
           0         446       -1133;
           0           0           1]
       
% X=[0 0;
%     1 4;
%     1 5;
%     1 6;
%     0 1;
%     0 2;]  
% 
% x=[378 721.7;
%    462.6 989.5;
%    457.3 1073;
%    454 1170;
%    370.2 776.4;
%    368.9 843.1;
%    ]
       
X=[1 0; 
    2 0;
    1 1;
    2 1; 
    1 2; 
    2 2;
    1 3; 
    1 4;
    1 5 ;
    0 4; 
    0 5];
;
x=[303 693;
    402 682;
    319 781.3;
    417 771;
    334 874.3;
    417.7 866.2;
    349.5 969.7;
    364.8 1068;
    380.1 1169;
    262 1085;
    276.4 1187;
    ];
x=x'
X=X'
H=getH_Homo(x,X);
P=get_P_from_H(H,K);


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
figure, imshow(I), hold on, title('Detected features frame 2');
plot(est(:,1),est(:,2),'r')

