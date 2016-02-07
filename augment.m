function coord_cube=augment(videoFrame, pointTracker, caliberated_points)
    caliberated_point_box=[0 0 0 1; 0 1 0 1;   1 1 0 1; 1 0 0 1;  1 0 1 1; 0 0 1 1; 0 1 1 1; 1 1 1 1;1 0 1 1; 0 0 1 1; 0 0 0 1;
            1 0 0 1 ; 1 1 0 1; 0 1 0 1;0 1 1 1 ;1 1 1 1;1 1 0 1];
    % Track the points. Note that some points may be lost.
    [points, isFound] = step(pointTracker, rgb2gray(videoFrame));
    visiblePoints = points(isFound, :);
    if ~isempty(visiblePoints)
         H=getH_Homo(caliberated_points, visiblePoints);
         P_n=get_P_from_H(H);
         caliberated_point_box=caliberated_point_box';
        est=P_n*caliberated_point_box;
        h=size(caliberated_point_box,2);

        for i=1:h
            for k=1:3
            est(k,i)=est(k,i)/est(3,i);
            end
        end

    end
    coord_cube=est;
end
    
    

