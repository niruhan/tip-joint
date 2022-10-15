clc
clear 
close all

useConjugateGradient = false;

% Read noisy lena image
noisy_img = imread("img/noisy_lena.png");

subplot(1,3,1), imshow(noisy_img), title('Noisy Image')

kernel_halfwidth = 3;
kernel_size = 2 * kernel_halfwidth + 1;
patch_height = 10;
patch_width = 10;
% 
g = gaussianFilter(kernel_size, 2);
% 
psi = preparePsi(g, patch_height, patch_width, kernel_halfwidth);

% run sinhorn knopp normalization on g
psi_normalized = sinkhornKnopp(psi);

% linear denoising using normalised psi
linear_denoising_output = patchwiseProcess(noisy_img, patch_height, patch_width, false, psi_normalized);

% generate image from the filtered output
linear_filtered_image = mat2gray(linear_denoising_output);
subplot(1,3,2), imshow(linear_filtered_image), title('Linear Filter Output')

% denoising using graph filter
% define laplacian denoiser using theorem 1
mu = 0.1;
I = eye(patch_height * patch_width);
laplacian = (inv(psi_normalized) - I) / mu;

if (useConjugateGradient)
    multiplier = I + mu * laplacian;
else
    multiplier = inv(I + mu * laplacian);
end

graph_filter_output = patchwiseProcess(noisy_img, patch_height, patch_width, useConjugateGradient, multiplier);

% generate image from the filtered output
graph_filtered_image = mat2gray(graph_filter_output);
subplot(1,3,3), imshow(graph_filtered_image), title('Graph Filter Output')

ssd = calculateSsd(linear_denoising_output, graph_filter_output);
