img = imread("img/lena_gray.png");
figure,
imshow(img);
noisy_img = imnoise(img,"gaussian");
figure,
imshow(noisy_img);

[h, w] = size(img);
img_matrix = im2double(noisy_img);
filter_output = zeros(h, w);

hw = 5;
a = hw;
b = hw;

[Y,X] = meshgrid(-a:a, -b:b);
sigma = 1.5;
g = exp(-(X.^2 + Y.^2)/sigma^2);
% surf(g)

for m=a+1:h-a
    for n=b+1:w-b
        filter_output(m,n) = sum(sum(img_matrix(m-a:m+a, n-b:n+b).*g));
    end
end

figure,
filtered_image = mat2gray(filter_output);
imshow(filtered_image);