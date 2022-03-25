clc; clear; close all
% read image from file
rgb_img = imread('img.jpg');

% convert to grayscale8 bit
gray_img = rgb2gray(rgb_img);
%imshow(gray_img);

subplot(2, 4, 1),
imshow(gray_img);
title("Gray Scale Image");
 
% Sobel Edge Detection
J = edge(gray_img, 'Sobel');
subplot(2, 4, 2),
imshow(J);
title("Sobel");
 
% Prewitt Edge detection
K = edge(gray_img, 'Prewitt');
subplot(2, 4, 3),
imshow(K);
title("Prewitt");
 
% Robert Edge Detection
L = edge(gray_img, 'Roberts');
subplot(2, 4, 4),
imshow(L);
title("Robert");
 
% Log Edge Detection
M = edge(gray_img, 'log');
subplot(2, 4, 5),
imshow(M);
title("Log");
 
% Zerocross Edge Detection
M = edge(gray_img, 'zerocross');
subplot(2, 4, 6),
imshow(M);
title("Zerocross");
 
% Canny Edge Detection
N = edge(gray_img, 'Canny');
subplot(2, 4, 7),
imshow(N);
title("Canny");

% =====================================

% add noise to gray_img with snr=6
double_gray_img = cast(gray_img, 'double');
noisy_img = awgn(double_gray_img, 6, 'measured');
imshowpair(gray_img, noisy_img, 'montage');

% =====================



[peaksnr_init, snr_init] = psnr(gray_img, gray_img);
disp(['The Peak-SNR value at the begining ', num2str(peaksnr_init)]);

[peaksnr_before_noise_removal, snr_before] = psnr(cast(noisy_img, 'uint8'), gray_img);
disp(['The Peak-SNR value before noise reduction ', num2str(peaksnr_before_noise_removal)]);

% remove niose from picture with wiener2
no_noise_img_wiener2 = wiener2(noisy_img);
imwrite(no_noise_img_wiener2, 'after_noise_img_wiener2.png');
imshowpair(no_noise_img_wiener2, noisy_img, 'montage');
[peaksnr_w, snr_w] = psnr(cast(no_noise_img_wiener2, 'uint8'), gray_img);
disp(['The Peak-SNR value wiht wiener2 is ', num2str(peaksnr_w)]);
% % =============================


% remove niose from picture with Conv2
dd = fspecial('average', 3);
no_noise_img_conv2 = conv2(noisy_img, dd, 'same');
imwrite(cast(no_noise_img_conv2, 'uint8'), 'after_noise_img_conv2.png');
imshowpair(no_noise_img_conv2, noisy_img, 'montage');
[peaksnr_conv2, snr_conv2] = psnr(cast(no_noise_img_conv2, 'uint8'), gray_img);
disp(['The Peak-SNR  value with Conv2 function is ', num2str(peaksnr_conv2)]);
% =============================


% remove niose from picture with Medfilt2
no_noise_img_medfilt2 = medfilt2(noisy_img);
imwrite(no_noise_img_medfilt2, 'after_noise_img_medfilt2.png');
imshowpair(no_noise_img_medfilt2, noisy_img, 'montage');
[peaksnr_med, snr_med] = psnr(cast(no_noise_img_medfilt2, 'uint8'), gray_img);
disp(['The Peak-SNR  value with medfilt2 function is ', num2str(peaksnr_med)]);
% =============================



% remove niose from picture with filter
dd = fspecial('average', 3);
no_noise_img_filter2 =  filter2(dd, noisy_img);
imwrite(cast(no_noise_img_filter2, 'uint8'), 'after_noise_img_filter2.png');
imshowpair(no_noise_img_filter2, noisy_img, 'montage');
[peaksnr_filter, snr_filter] = psnr(cast(no_noise_img_filter2, 'uint8'), gray_img);
disp(['The Peak-SNR  value with filter2 function is ', num2str(peaksnr_filter)]);
% ==============================
