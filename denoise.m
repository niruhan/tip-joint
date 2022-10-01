img = imread("img/lena_gray.png");
imshow(img);
noisy_img = imnoise(img,"gaussian");
imshow(noisy_img);