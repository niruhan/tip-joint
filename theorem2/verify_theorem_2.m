clc
clear 
close all

% Read noisy lena image
noisy_img = imread("img/lena_gray.png");

% subplot(1,3,1), imshow(noisy_img), title('Image')

m = 4;
n = 2;

gamma = 0.4;
theta = [1/2, 1/2, 0, 0; 0, 0, 1/2, 1/2];
H = zeros(m, m + n);
H(1, 1) = 1;
H(2, 2) = 1;
H(3, 3) = 1;
H(4, 4) = 1;
Amn = 2 * theta' * inv(theta * theta');
A = zeros(m + n, m + n);
A(1:m, m+1:m+n) = Amn;


temp = H' * H + gamma * (H' * H + A' * H' * H * A - 2 * A' * H' * H);

noisy_img_patch = noisy_img(1:2, 1:2);
flattened_patch = reshape(noisy_img_patch.',[],1);

p = pinv(temp);
q = p * H';

x = q * double(flattened_patch);
interpolated_patch = x * (1 + gamma);
interpolated_patch = reshape(interpolated_patch, )