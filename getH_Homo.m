function h = getH_Homo(x, X)

[A,b] = get_A_Homo(x, X);
h=A\b;

return