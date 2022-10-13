clc
clear 
close all
% Read noisy lena image
noisy_img = imread("img/noisy_lena.png");
% figure,
% imshow(noisy_img);

% generate matrix o double type with the image values
[h, w] = size(noisy_img);
noisy_img_matrix = im2double(noisy_img);
filter_output = zeros(h, w);

kernel_halfwidth = 1;
patch_height = 10;
patch_width = 10;

g = gaussianFilter(2 * kernel_halfwidth + 1, 2);

psi = zeros(patch_height * patch_width);

for row = 1 : patch_height
    for col = 1 : patch_width
        temp_patch = zeros(patch_height + 2*kernel_halfwidth, patch_width+ 2*kernel_halfwidth);
        temp_patch(row: row + 2 * kernel_halfwidth, col:col + 2*kernel_halfwidth) = g;
%         disp(temp_patch)
        psi((row-1)*patch_width + col,:) = reshape(temp_patch(kernel_halfwidth + 1: patch_height + kernel_halfwidth, kernel_halfwidth + 1:patch_width+kernel_halfwidth).',1,[]);
    end
end

% run sinhorn knopp normalization on g
psi_normalized = sinkhornKnopp(psi);

% find the start coordinates of the patch
patch_start_vertical = 1;
patch_start_horizontal = 1;

% find the end coordinates of the patch
patch_end_vertical = 10;
patch_end_horizontal = 10;

noisy_img_patch = noisy_img_matrix(patch_start_vertical: patch_end_vertical, patch_start_horizontal: patch_end_horizontal);
imwrite(mat2gray(noisy_img_patch), 'img/noisy_img_patch.png');
flattened_patch = reshape(noisy_img_patch.',1,[]);

% show the noisy patch as image
figure,
patch_image = mat2gray(noisy_img_patch);
imshow(patch_image);

filter_output = psi_normalized * flattened_patch';

rearranged_output = reshape(filter_output, patch_height, patch_width);

% generate image from the filtered output
figure,
filtered_image = mat2gray(rearranged_output);
imshow(filtered_image);
imwrite(filtered_image, 'img/filtered_image.png');
