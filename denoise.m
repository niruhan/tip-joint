% Read noisy lena image
noisy_img = imread("img/noisy_lena.png");
figure,
imshow(noisy_img);

% generate matrix o double type with the image values
[h, w] = size(noisy_img);
img_matrix = im2double(noisy_img);
filter_output = zeros(h, w);

hw = 1;
a = hw;
b = hw;

% define 2D gaussian function
[Y,X] = meshgrid(-a:a, -b:b);
sigma = 1.5;
g = exp(-(X.^2 + Y.^2)/sigma^2);
% surf(g)

% convolve the noisy image with the gaussian filter
for m=a+1:h-a
    for n=b+1:w-b
        filter_output(m,n) = sum(sum(img_matrix(m-a:m+a, n-b:n+b).*g));
    end
end

% generate image from the filtered output
figure,
filtered_image = mat2gray(filter_output);
imshow(filtered_image);