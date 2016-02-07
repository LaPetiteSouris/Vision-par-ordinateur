clc;
close all;
clear all;
v = vision.VideoFileReader('o.ogv');
frame1=step(v);
I=rgb2gray(frame1);
points = detectHarrisFeatures(I);
figure, imshow(I), hold on, title('Detected features frame 1');
plot(points(15:25));


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