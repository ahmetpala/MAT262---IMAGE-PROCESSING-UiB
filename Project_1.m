I = imread('cameraman.tif');
subplot(1, 3, 1);
imshow(I); 
title('Original Image');

Noisy = imnoise(imread('cameraman.tif'),'gaussian');
subplot(1, 3, 2);
imshow(Noisy); 
title('Gaussian Noise Added Image');

B = double(Noisy);
sz = size(B,1)*size(B,2);

% Defining the filter window size
M = 7;
N = 7;

% Padding the matrices with zeros on all sides
C = padarray(B,[floor(M/2),floor(N/2)]);
local_var = zeros([size(B,1) size(B,2)]);
local_mean = zeros([size(B,1) size(B,2)]);
temp = zeros([size(B,1) size(B,2)]);

for i = 1:size(C,1)-(M-1)
    for j = 1:size(C,2)-(N-1)
        temp = C(i:i+(M-1),j:j+(N-1));
        tmp =  temp(:);
        %Calculating the local mean and local variances
        local_mean(i,j) = mean(tmp);
        local_var(i,j) = mean(tmp.^2)-mean(tmp).^2;
    end
end

%Noise variance and average of the local variance
noise_var = sum(local_var(:))/sz;

% Filtered Image = B - (noise variance/(noise variance + local variance))*(B-local_mean);
Filtered = noise_var./(noise_var + local_var);
Filtered = Filtered.*(B-local_mean);
Filtered = B-Filtered;

% Scaling the pixel values between 0 and 255.
Filtered = uint8(Filtered);
subplot(1, 3, 3);
imshow(Filtered);
title('Restored Image using Adaptive Local filter');


