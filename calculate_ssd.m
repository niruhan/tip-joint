image1 = im2double(imread('img/filtered_image.png'));
image2 = im2double(imread('img/filtered_image_l.png'));
[h, w] = size(image1);

h = h - 1;
ssd = 0;

for i = 1:h
    for j = 1:w
        diff = (image1(i,j) - image2(i,j));
        diff = diff * 255;
        ssd = ssd + diff^2;
    end
end