I = imread('red-eye.tif'); % Image from assignment
%I = imread('red-eye2.png'); % Other image for trial

thresh = 148; % 148 is found after several trials

cform = makecform('srgb2cmyk'); % Color transformation structure 
img_lab = applycform(I,cform); % Applying transform
mask = (img_lab(:,:,2) > thresh);% Pixels larger than the threshold values

% Extracting different color channels
red = I(:,:,1);
green = I(:,:,2);
blue = I(:,:,3);
red(mask) = round((green(mask)+blue(mask))/2); % Replacing red value with (G+B)/2
output = cat(3,red,green,blue); % Combining color channels to form output image

subplot(1,2,1);
imshow(I);
title('Original Image');

subplot(1,2,2);
imshow(output);
title('Corrected Image');
