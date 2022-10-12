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

for row = 1:h/3
    % find the vertical coordinates of the patch
    patch_start_vertical = (row - 1) * 3 + 1;
    patch_end_vertical = (row - 1) * 3 + 3;
    for col = 1: w/3
        % find the end coordinates of the patch
        patch_start_horizontal = (col - 1) * 3 + 1;
        patch_end_horizontal = (col - 1) * 3 + 3;

        disp(patch_start_vertical)
        disp(patch_start_horizontal)
        disp(patch_end_vertical)
        disp(patch_end_horizontal)

        noisy_img_patch = noisy_img_matrix(patch_start_vertical: patch_end_vertical, patch_start_horizontal: patch_end_horizontal);
%         imwrite(mat2gray(noisy_img_patch), 'img/noisy_img_patch.png');
        flattened_patch = reshape(noisy_img_patch.',1,[]);

        flat_output = g_normalized * flattened_patch';
        matrix_output = [flattened_patch(1:3); flattened_patch(4:6); flattened_patch(7:9)];
        filter_output(patch_start_vertical: patch_end_vertical, patch_start_horizontal: patch_end_horizontal) = matrix_output;
    end
end

% show the noisy patch as image
% figure,
% patch_image = mat2gray(noisy_img_patch);
% imshow(patch_image);

% generate image from the filtered output
figure,
filtered_image = mat2gray(filter_output);
imshow(filtered_image);
imwrite(filtered_image, 'img/oct-11-mat-vec-denoised.png');
