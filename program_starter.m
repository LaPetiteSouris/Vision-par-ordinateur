% % % Launcher to start main program

clc;
close all;
clear all;
% Points to be tracked
X = [ 0 4;
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
% Track these points in every frame of the video
videoFileReader = vision.VideoFileReader('o.ogv');
firstframe = step(videoFileReader);

I = rgb2gray(firstframe);
points = detectHarrisFeatures(I);
% Take only visible reconizable points
points = points(15: 25);
points = points.Location;


% Initialize tracker

pointTracker = vision.PointTracker('MaxBidirectionalError', 2);

% Initialize the tracker with the tracker points and the initial
% video frame.
initialize(pointTracker, double(points), rgb2gray(firstframe));

i = 0;
% For each extracted frame, we track the new positions of trackers points
% then call augment function, which takes care of the augmented reality part
% In this case, we work only for first 65 frames
while i < 65
		i = i + 1;
		% get the next frame
		videoFrame = step(videoFileReader);
		[coord_cube, visiblepoints] = augment(videoFrame, pointTracker, X);
		% Save new frame to image
		h = figure('visible', 'off');
		I = rgb2gray(videoFrame);
		imshow(I), hold on,
		       plot(coord_cube(:, 1), coord_cube(:, 2), 'r')
               plot(visiblepoints(:, 1), visiblepoints(:, 2), 'go')
		       path = './frames';
		frame_pic = strcat('frame', num2str(i), '.png');
		saveas(h, fullfile(path, frame_pic));
		close(gcf)


end
vidObj = VideoWriter('aug_video.avi');
vidObj.FrameRate = 23;
open(vidObj);
% Save augmented frames to new video
for i = 1 : 64
        path = './frames/';
		frame_pic = strcat('frame', num2str(i), '.png');
		frame_pic = strcat(path, frame_pic);
		Img = imread(frame_pic);
		% add the image to your movie:
		f = im2frame(Img);
		writeVideo(vidObj, f);

end
close(vidObj)
