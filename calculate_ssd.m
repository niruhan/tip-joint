image1 = im2double(imread('img/oct-11-mat-vec-denoised.png'));
image2 = im2double(imread('img/oct-11-laplacian-denoised.png'));
[h, w] = size(image1);

% h = h;
ssd = 0;

for i = 1:h
    for j = 1:w
        diff = (image1(i,j) - image2(i,j));
        diff = diff * 255;
        ssd = ssd + diff^2;
    end
end