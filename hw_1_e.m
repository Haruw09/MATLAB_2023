[X,Y] = meshgrid(1:20, 1:20);
Z = besselj(1,X)*(0.5 * sqrt(X^2 + Y^2))^2 / (X^2 + Y^2);
surface(X, Y, Z);
view(3);