function filter_output = patchwiseProcess(noisy_img, patch_height, patch_width, useConjugateGradient, multiplier)
    [h, w] = size(noisy_img);
    % generate matrix o double type with the image values
    noisy_img_matrix = im2double(noisy_img);
    filter_output = zeros(h, w);
    for row = 1:h/patch_height
        % find the vertical coordinates of the patch
        patch_start_vertical = (row - 1) * patch_height + 1;
        patch_end_vertical = row * patch_height;
        for col = 1: w/patch_width
            % find the end coordinates of the patch
            patch_start_horizontal = (col - 1) * patch_width + 1;
            patch_end_horizontal = col * patch_width;
    
            noisy_img_patch = noisy_img_matrix(patch_start_vertical: patch_end_vertical, patch_start_horizontal: patch_end_horizontal);
            flattened_patch = reshape(noisy_img_patch.',[],1);
    
            if (useConjugateGradient)
                flat_output = conjgrad(multiplier, flattened_patch);
            else
                flat_output = multiplier * flattened_patch;
            end
            matrix_output = reshape(flat_output, patch_height, patch_width);
            filter_output(patch_start_vertical: patch_end_vertical, patch_start_horizontal: patch_end_horizontal) = matrix_output';
        end
    end
end