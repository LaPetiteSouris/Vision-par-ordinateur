points=[0 0 0;0 1 0;1 1 0;1 0 0;0 0 1;0 1 1; 1 1 1;1 0 1];
points=points';
plot3(points(1,:),points(2,:),points(3,:))
% faces=[1 2 3 4;2 6 7 3;4 3 7 8;1 5 8 4;1 2 6 5;5 6 7 8];
% patch('Vertices',points,'Faces',faces,'FaceColor','g')