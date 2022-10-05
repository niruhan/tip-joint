image1 = im2double(imread('img/gaussian_filtered_img.png'));
image2 = im2double(imread('img/laplacian_filtered_img.png'));
[h, w] = size(image1);

h = h - 1;
ssd = 0;

for i = 1:h
    for j = 1:w
        diff = (image1(i,j) - image2(i+1,j));
        diff = diff * 255;
        ssd = ssd + diff^2;
    end
end