% % % We have to extract the 1st frame of the video for calibeartion
% % % Firstly, we detect Harris features points, then manually define the coordinate of
% % % those points in world coordinate. These points are our tracking points.

v = VideoReader('o.avi');
I = read(v, 1);
I = rgb2gray(I);
points = detectHarrisFeatures(I);

figure, imshow(I), hold on, title('Detected features frame 1');
% We take only strong corner points
for i=15:1:23
    point=points(i);
    plot(point.Location(1),point.Location(2),'go', 'LineWidth',3);
end


K =[
    
2239.9398557735         -38.2539086481364          1738.67177844411;
0          2201.84011397067          1896.54836489851;
0                         0                         1];





% Tracking points in world coordinate

X = [1 0;
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

% Image coordinate of tracking points in 1st frame
x = [303 693;
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
% Using 2 pairs of vectors points, calcuate Homography matrix and the Projection matrix
x = x';
X=X';
H = getH_Homo(x, X);
P = get_P_from_H(H, K);

% Testing by projecting a cube on the caliberated image
c = [0 0 0 1; 0 1 0 1;   1 1 0 1; 1 0 0 1;  1 0 -1 1; 0 0 -1 1; 0 1 -1 1; 1 1 -1 1; 1 0 -1 1; 0 0 -1 1; 0 0 0 1;
    1 0 0 1 ; 1 1 0 1; 0 1 0 1; 0 1 -1 1 ; 1 1 -1 1; 1 1 0 1];

c = c';
est=P*c;
h=size(c,2);

for i=1:h
    for k=1:3
        est(k,i)=est(k,i)/est(3,i);
    end
    
end

est=est';
%
figure, imshow(I), hold on, title('Detected features  and projected cube in frame 1');
plot(est(:, 1), est(:, 2), 'r','LineWidth',2)

