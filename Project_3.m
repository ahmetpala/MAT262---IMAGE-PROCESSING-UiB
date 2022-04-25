I = imread('car-moire-pattern.tif');

subplot(2, 2, 1);
imshow(I, []);
title('Original Image with Moire Noise')

Spectrum = fftshift(fft2(I));
Spectrum = log(abs(Spectrum));
subplot(2, 2, 2);
imshow(Spectrum, []);
title('Spectrum');

ampImage = Spectrum;

% Finding the location of the big spikes
ampThreshold = 9;
brSpikes = ampImage > ampThreshold; % Binary image.

% Excluding the central DC spike.  Everything from row 90 to 155.
brSpikes(90:155, :) = 0;

% Filtering the spectrum.
fImage = fftshift(fft2(I));
fImage(brSpikes) = 0;
% Logarithm of the abs values of frequency image
ampImage2 = log(abs(fImage));
minValue = min(min(ampImage2));
maxValue = max(max(ampImage2));
subplot(2, 2, 3);
imshow(ampImage2, [minValue maxValue]);
title('Zeroed Spikes');


finalImage = ifft2(fftshift(fImage),'nonsymmetric');
ampImage3 = abs(finalImage);
minValue = min(min(ampImage3));
maxValue = max(max(ampImage3));
subplot(2, 2, 4);
imshow(ampImage3, [minValue maxValue]);
title('Filtered Image');

