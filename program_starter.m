clc;
close all;
clear all;
%Points to be tracked
X=[ 0 4;
    0 5;
    1 0;
    1 1;
    1 2;
    1 3;
    1 4;
    1 5;
    2 0;
    2 1;
    2 2];
v_write = VideoWriter('out.avi');
open(v_write);
videoFileReader = vision.VideoFileReader('o.ogv');
firstframe= step(videoFileReader);

I=rgb2gray(firstframe);
points = detectHarrisFeatures(I);
%Take only visible reconizable points
points=points(15:25);
points = points.Location;


%Initialize tracker

pointTracker = vision.PointTracker('MaxBidirectionalError', 2);

% Initialize the tracker with the initial point locations and the initial
% video frame.
initialize(pointTracker, double(points), rgb2gray(firstframe));


while ~isDone(videoFileReader)
    % get the next frame
    videoFrame = step(videoFileReader);
    coord_cube=augment(videoFrame, pointTracker, X);
    %Save new frame to image
    h = figure('visible', 'off');
    I=rgb2gray(videoFrame);
    imshow(I), hold on,
    plot(coord_cube(:,1),coord_cube(:,2),'r')
    saveas(h,'aug_img.png');
    %Save augmented frame to new video
%     I_A=imread('au_img.png');
%     
%     writeVideo(v,I_A);
    
end
close(v_write);
