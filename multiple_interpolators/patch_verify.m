clc
clear 
close all

% Read lena image
% img = imread("img/lena_gray.png");
% 
% img_patch = img(10:11, 20:21);

img_patch = [153, 156; 157, 158];
flattened_patch = reshape(img_patch.',[],1);

m = 4;
n1 = 2;
n2 = 3;
gamma = 0.4;

theta1 = [[0.5, 0.5, 0, 0]; [0, 0, 0.5, 0.5]];
theta2 = [[0.75, 0, 0.25, 0]; [0.25, 0.25, 0.25, 0.25]; [0, 0.5, 0, 0.5]];

% linear interpolation
linear_interp1 = theta1 * double(flattened_patch);
linear_interp2 = theta2 * double(flattened_patch);

linear_interpolated_patch = zeros(3, 3);
linear_interpolated_patch(1, 1) = img_patch(1, 1);
linear_interpolated_patch(1, 3) = img_patch(1, 2);
linear_interpolated_patch(3, 1) = img_patch(2, 1);
linear_interpolated_patch(3, 3) = img_patch(2, 2);

linear_interpolated_patch(1, 2) = linear_interp1(1);
linear_interpolated_patch(3, 2) = linear_interp1(2);

linear_interpolated_patch(2, 1) = linear_interp2(1);
linear_interpolated_patch(2, 2) = linear_interp2(2);
linear_interpolated_patch(2, 3) = linear_interp2(3);

% graph interpolation

H = zeros(m, m + n1 + n2);
H(1, 1) = 1;
H(2, 2) = 1;
H(3, 3) = 1;
H(4, 4) = 1;

A1mn = 2 * theta1' * inv(theta1 * theta1');
A1 = zeros(m + n1 + n2, m + n1 + n2);
A1(1:m, m+1:m+n1) = A1mn;

temp1 = H' * H - 2 * A1' * H' * H + A1' * H' * H * A1;

A2mn = 2 * theta2' * inv(theta2 * theta2');
A2 = zeros(m + n1 + n2, m + n1 + n2);
A2(1:m, m+n1+1:m+n1+n2) = A2mn;

temp2 = H' * H - 2 * A2' * H' * H + A2' * H' * H * A2;

coeff = H' * H + gamma * (temp1 + temp2);

graph_interpolated_patch = inv(coeff) * H' * double(flattened_patch);

graph_interpolated_patch = (1 + gamma) * graph_interpolated_patch;

