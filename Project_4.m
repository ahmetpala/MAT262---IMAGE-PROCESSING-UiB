I = imread('dentalXray.tif');

image_name= 'dentalXray.tif'; 
teeth_image=imread(image_name);
subplot(2,3,1);
imshow(teeth_image, []);
title('Original Image');

level = graythresh(I);
BW = imbinarize(I,level);
subplot(2,3,2);
imshow(BW, []);
title('Otsus Thresholding Image');

segmented_teeth=imbinarize(I,0.685); %0.685 is the best one
subplot(2,3,3);
imshow(segmented_teeth, []);
title('Manual Global Threshold Segmented Image');

w = fspecial('average', 5);
fa = imfilter(I, w, 'replicate');
Ta = graythresh(fa);
ga = imbinarize(fa, Ta);
subplot(2,3,4);
imshow(ga, []);
title('Otsus Segmentation after Noise Removal');

T = adaptthresh(I, 0.6);
BWl = imbinarize(I,T);
subplot(2,3,5);
imshow(BWl, []);
title('Adaptive Thresholding');

[L,Centers] = imsegkmeans(I,2);
B = labeloverlay(I,L);
subplot(2,3,6);
imshow(B)
title('K-Means Image')

