hw = 1;
a = hw;
b = hw;

% define 2D gaussian function
[Y,X] = meshgrid(-a:a, -b:b);
sigma = 1.5;
g = exp(-(X.^2 + Y.^2)/sigma^2);

% define laplacian denoiser using theorem 1
laplacian = 