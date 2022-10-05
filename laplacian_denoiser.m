hw = 1;
a = hw;
b = hw;

% define 2D gaussian function
% [Y,X] = meshgrid(-a:a, -b:b);
% sigma = 2;
% g = exp(-(X.^2 + Y.^2)/sigma^2);

% define a 3x3 filter with all values equal to 1/9
% g = [1/9, 1/9, 1/9; 1/9, 1/9, 1/9; 1/9, 1/9, 1/9;];

% define a 3x3 gaussial-like filter
% g = [1, 2, 1; 2, 4, 2; 1, 2, 1;];

% define a random invertible matrix as filter
g = [1, 2, -1; 2, 1, 2; -1, 2, 1;];

% define laplacian denoiser using theorem 1
mu = 0.1;
I = eye(2 * hw + 1);
laplacian = mu * (inv(g) - I);

% Read noisy lena image
noisy_img = imread("img/noisy_lena.png");
% figure,
% imshow(noisy_img);

% generate matrix o double type with the image values
[h, w] = size(noisy_img);
noisy_img_matrix = im2double(noisy_img);
filter_output = zeros(h, w);

multiplier = inv(I + mu * laplacian);

% filtered_image = multiplier * noisy_img_matrix;

% do patch-wise matrix multiplication
filter_height = (2 * hw + 1);
filter_width = (2 * hw + 1);

for m = 1 : (h / filter_height)
    for n= 1 : (w / filter_width)

        % find the start coordinates of the patch
        patch_start_vertical = (m - 1) * filter_height + 1;
        patch_start_horizontal = (n - 1) * filter_height + 1;

        % find the end coordinates of the patch
        patch_end_vertical = patch_start_vertical + filter_height - 1;
        patch_end_horizontal = patch_start_horizontal + filter_width - 1;

        % extract the patch to process from noisy image
        noisy_img_patch = noisy_img_matrix(patch_start_vertical: patch_end_vertical, patch_start_horizontal: patch_end_horizontal);
        
        % multiply with (I + mu * L)^(-1) and assign to output
        filter_output(patch_start_vertical:patch_end_vertical, patch_start_horizontal: patch_end_horizontal) = multiplier * noisy_img_patch;
    end
end

% generate image from the filtered output
figure,
filtered_image = mat2gray(filter_output);
imshow(filtered_image);

imwrite(filtered_image, 'img/laplacian_filtered_img.png');


