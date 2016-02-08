function [R,Q] = rq(A)
[q,r]=qr(A');
R=r';Q=q';
end
