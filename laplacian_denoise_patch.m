% Read noisy lena image
noisy_img = imread("img/noisy_lena.png");
% figure,
% imshow(noisy_img);

% generate matrix o double type with the image values
[h, w] = size(noisy_img);
noisy_img_matrix = im2double(noisy_img);
filter_output = zeros(h, w);

hw = 1;
a = hw;
b = hw;

% define a 9x9 filter
row1 = [1,1,0,1,1,0,0,0,0];
row2 = [1,1,1,1,1,1,0,0,0];
row3 = [0,1,1,0,1,1,0,0,0];
row4 = [1,1,0,1,1,0,1,1,0];
row5 = [1,1,1,1,1,1,1,1,1];
row6 = [0,1,1,0,1,1,0,1,1];
row7 = [0,0,0,1,1,0,1,1,0];
row8 = [0,0,0,1,1,1,1,1,1];
row9 = [0,0,0,0,1,1,0,1,1];

g = [row1;row2;row3;row4;row5;row6;row7;row8;row9];

% run sinhorn knopp normalization on g
g_normalized = sinkhornKnopp(g);

% define laplacian denoiser using theorem 1
mu = 0.1;
I = eye(9);
laplacian = (inv(g_normalized) - I) / mu;

multiplier = inv(I + mu * laplacian);

% find the start coordinates of the patch
patch_start_vertical = 1;
patch_start_horizontal = 1;

% find the end coordinates of the patch
patch_end_vertical = 3;
patch_end_horizontal = 3;

noisy_img_patch = noisy_img_matrix(patch_start_vertical: patch_end_vertical, patch_start_horizontal: patch_end_horizontal);
flattened_patch = reshape(noisy_img_patch.',1,[]);

% show the noisy patch as image
figure,
patch_image = mat2gray(noisy_img_patch);
imshow(patch_image);

filter_output_l = multiplier * flattened_patch';

rearranged_output_l = [filter_output_l(1:3)'; filter_output_l(4:6)'; filter_output_l(7:9)'];

% generate image from the filtered output
figure,
% % Enlarge figure to full screen.
% set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
filtered_image_l = mat2gray(rearranged_output_l);
imshow(filtered_image_l);
imwrite(filtered_image_l, 'img/filtered_image_l.png');
