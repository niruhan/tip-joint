clc
clear
close all

% Read lena image
% img = imread("img/lena_gray.png");
% 
% img_patch = img(10:11, 20:21);

img_patch = [153, 156; 157, 158];
flattened_patch = reshape(img_patch.',[],1);

mu = 0.3;
gamma = 0.4;
% psi = [0.15, 0.25, 0.35, 0.25; 0.25, 0.25, 0.25, 0.25; 0.25, 0.25, 0.25, 0.25; 0.25, 0.25, 0.25, 0.25];
psi = [0.3188, 0.1432, 0.3735, 0.1644;
    0.1432, 0.2775, 0.2057, 0.3735;
    0.2244, 0.3549, 0.2775, 0.1432;
    0.3135, 0.2244, 0.1432, 0.3188];
theta = [0.5, 0.5, 0, 0; 0, 0, 0.5, 0.5];

% linear denoise then interpolate
linear_denoised_patch = psi * flattened_patch;
linear_interp = theta * linear_denoised_patch;
linear_output = zeros(2, 3);
linear_output(1, 1) = linear_denoised_patch(1);
linear_output(1, 3) = linear_denoised_patch(2);
linear_output(2, 1) = linear_denoised_patch(3);
linear_output(2, 3) = linear_denoised_patch(4);

linear_output(1, 2) = linear_interp(1, 1);
linear_output(2, 2) = linear_interp(2, 1);

% graph denoise and interpolate
laplacian = (inv(psi) * (1 + gamma) * eye(4)) / mu;
H = zeros(4, 6);
H(1, 1) = 1;
H(2, 2) = 1;
H(3, 3) = 1;
H(4, 4) = 1;
