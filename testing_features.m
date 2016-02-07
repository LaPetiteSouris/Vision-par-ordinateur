

I1 = rgb2gray(imread('check.jpg'));
I2 = rgb2gray(imread('chess2.jpg'));



points = detectHarrisFeatures(I1);

figure, imshow(I1), hold on, title('Detected features frame 1');
plot(points(20:30));
pointTracker = vision.PointTracker('MaxBidirectionalError', 2);

points = points.Location;
initialize(pointTracker, points, I1);
oldPoints=points;
[p2,isfound] = step(pointTracker,I2)

visiblePoints = p2(isfound, :);
oldInliers = oldPoints(isfound, :);


figure, imshow(I1), hold on, title('Detected features frame 1');
plot(oldInliers(:,1),oldInliers(:,2),'go')


figure, imshow(I2), hold on, title('Detected features frame 2');
plot(visiblePoints(:,1),visiblePoints(:,2),'go')


% indexPairs = matchFeatures(f1, f2) ;
% matchedPoints1 = vpts1(indexPairs(1:10, 1));
% matchedPoints2 = vpts2(indexPairs(1:10, 2));
% 
% 
% 
% figure; ax = axes;
% showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2,'montage');
% title(ax, 'Candidate point matches');
% legend(ax, 'Matched points 1','Matched points 2');

