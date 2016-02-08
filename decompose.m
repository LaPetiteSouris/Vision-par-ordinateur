function K=decompose(M);



a1 = M(1,1:3);
a2 = M(2,1:3);
a3 = M(3,1:3);
b = M(1:3, 4);
r3 = a3;
%compute the intrinsic parameters
u_0 = a1*a3';
v_0 = a2*a3';
cross_a1a3 = cross(a1,a3);
cross_a2a3 = cross(a2,a3);
theta = acos (-1*cross_a1a3*cross_a2a3'/(norm(cross_a1a3)*norm(cross_a2a3)));
alpha = norm(cross_a1a3) * sin(theta);
beta = norm(cross_a2a3) * sin(theta);
%compute the extrinsic parameters
r1 = cross_a2a3/norm(cross_a2a3);
r2 = cross(r3, r1);
K = [alpha -1*alpha*cot(theta) u_0
0 beta/sin(theta) v_0
0 0 1];

end