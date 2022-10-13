clc
clear 
close all

% Read noisy lena image
noisy_img = imread("img/noisy_lena.png");
figure,
imshow(noisy_img);

% generate matrix o double type with the image values
[h, w] = size(noisy_img);
noisy_img_matrix = im2double(noisy_img);
filter_output = zeros(h, w);

kernel_halfwidth = 1;
kernel_size = 2 * kernel_halfwidth + 1;
patch_height = 10;
patch_width = 10;
% 
g = gaussianFilter(kernel_size, 2);
% 
psi = preparePsi(g, patch_height, patch_width, kernel_halfwidth);

% run sinhorn knopp normalization on g
psi_normalized = sinkhornKnopp(psi);

for row = 1:h/patch_height
    % find the vertical coordinates of the patch
    patch_start_vertical = (row - 1) * patch_height + 1;
    patch_end_vertical = row * patch_height;
    for col = 1: w/patch_width
        % find the end coordinates of the patch
        patch_start_horizontal = (col - 1) * patch_width + 1;
        patch_end_horizontal = col * patch_width;

        noisy_img_patch = noisy_img_matrix(patch_start_vertical: patch_end_vertical, patch_start_horizontal: patch_end_horizontal);
        flattened_patch = reshape(noisy_img_patch.',[],1);

        flat_output = psi_normalized * flattened_patch;
        matrix_output = reshape(flat_output, patch_height, patch_width);
        filter_output(patch_start_vertical: patch_end_vertical, patch_start_horizontal: patch_end_horizontal) = matrix_output';
    end
end

% generate image from the filtered output
figure,
filtered_image = mat2gray(filter_output);
imshow(filtered_image);
imwrite(filtered_image, 'img/oct-13-mat-vec-denoised.png');
