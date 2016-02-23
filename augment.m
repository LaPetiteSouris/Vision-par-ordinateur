function [coord_cube, visiblepoints]=augment(videoFrame, pointTracker, caliberated_points)
%% This function take care of augmented reality for each video videoFrame
%% For each video frame, it tracks the new position of trackers point to calculate Homography matrix H,
%% Then re-calculate projection matrix P and use P to project a small cube in new image.
%% Return: coordinate of projected cube on image and visible trackers points
%Camera instrinsic matrix K
K =[

           2239.9398557735         -38.2539086481364          1738.67177844411;
                         0          2201.84011397067          1896.54836489851;
                         0                         0                         1];
caliberated_point_box=[0 0 0 1; 0 1 0 1;   1 1 0 1; 1 0 0 1;  1 0 -1 1; 0 0 -1 1; 0 1 -1 1; 1 1 -1 1; 1 0 -1 1; 0 0 -1 1; 0 0 0 1;
    1 0 0 1 ; 1 1 0 1; 0 1 0 1; 0 1 -1 1 ; 1 1 -1 1; 1 1 0 1];
% Track the points. Note that some points may be lost. In case many tracker points are lost
% the reprojection will be seriously affected
[points, isFound] = step(pointTracker, rgb2gray(videoFrame));
visiblePoints = points(isFound, :);
caliberated_points=caliberated_points(isFound,:);
caliberated_points=caliberated_points';
visiblePoints=visiblePoints';
if ~isempty(visiblePoints)
    %Find new Homography H
    H=getH_Homo(visiblePoints,caliberated_points);
    %Find new projection matrix P
    P_n=get_P_from_H(H,K);
    caliberated_point_box=caliberated_point_box';
    %Project a cube in image
    est=P_n*caliberated_point_box;
    h=size(caliberated_point_box,2);
    
    for i=1:h
        for k=1:3
            est(k,i)=est(k,i)/est(3,i);
        end
    end
    
end
coord_cube=est';
visiblepoints=visiblePoints';
end



