%{
sampleIm = imread('Sample.jpg');

[sampleFilteredIm, gaussLPF] = GaussianLowPassFilter(sampleIm);

figure('Name', 'Guassian low-pass filter');
subplot(1, 3, 1)
imshow(sampleIm);
title('Original Image');
subplot(1, 3, 2);
imshow(uint8(gaussLPF * 255));
title('Guassian low-pass filter');
subplot(1, 3, 3);
imshow(sampleFilteredIm);
title('Filtered Image');

disp('-----Finished Solving Problem 1.1-----');
pause;

[bWorthFilteredIm, bWorthFilter] = ButterworthHighPassFilter(sampleIm);

figure('Name', 'Butterworth Filter');
subplot(1, 3, 1);
imshow(sampleIm);
title('Original Image');
subplot(1, 3, 2);
imshow(uint8(bWorthFilter * 255));
title('Butterworth Filter');
subplot(1, 3, 3);
imshow(bWorthFilteredIm);
title('Filtered Image');

disp('-----Finished Solving Problem 1.2-----');
pause;
%}

cityIm = imread('City.jpg');

[turbulentCityIm, H] = ApplyNoise(cityIm);
imwrite(turbulentCityIm, 'BlurCity.bmp');

figure;
subplot(1, 2, 1);
imshow(uint8(H*255));
title('Noise Filter');
subplot(1, 2, 2);
imshow(turbulentCityIm);
title('Filtered Image');

disp('-----Finished Solving Problem 2.1-----');
pause
close all;