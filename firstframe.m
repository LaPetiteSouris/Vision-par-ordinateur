clc;
close all;
clear all;
v = VideoReader('/home/tung/Desktop/small.ogv');
I= read(v,1);
I=rgb2gray(I);
points = detectHarrisFeatures(I);
figure, imshow(I), hold on, title('Detected features frame 1');
plot(points());