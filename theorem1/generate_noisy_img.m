% Read lena image
img = imread("img/lena_gray.png");
figure,
imshow(img);

% add noise to the image
noisy_img = imnoise(img,"gaussian");
figure,
imshow(noisy_img);
imwrite(noisy_img, 'img/noisy_lena.png');