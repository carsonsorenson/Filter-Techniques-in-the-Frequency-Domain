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
pause;

blurredCityIm = imread('BlurCity.bmp');
restoredIm = WienerFilter(blurredCityIm);
figure;
imshow(restoredIm);
title('Restored Image');

disp('-----Finished Solving Problem 2.2-----');
pause;

sampleIm = imread('Sample.jpg');
capitalIm = imread('Capital.jpg');

sampleImDouble = im2double(sampleIm);
capitalImDouble = im2double(capitalIm);

fftSampleIm = fftshift(fft2(sampleImDouble));
fftCapitalIm = fftshift(fft2(capitalImDouble));

sampleImMag = abs(fftSampleIm);
sampleImPhase = angle(fftSampleIm);
capitalImMag = abs(fftCapitalIm);
capitalImPhase = angle(fftCapitalIm);

figure;
subplot(2, 2, 1);
imshow(rescale(log(sampleImMag)));
title('Magnitude of Sample Image');
subplot(2, 2, 2);
imshow(rescale(sampleImPhase));
title('Phase of Sample Image');
subplot(2, 2, 3);
imshow(rescale(log(capitalImMag)));
title('Magnitude of Capital Image');
subplot(2, 2, 4);
imshow(rescale(capitalImPhase));
title('Phase of Capital Image');

disp('-----Finished Solving Problem 3.1-----');
pause;

capMixedMag = capitalImMag .* exp(1i * sampleImPhase);
sampleMixedMag = sampleImMag .* exp(1i * capitalImPhase);

capSampIm = ifft2(ifftshift(capMixedMag));
sampCapIm = ifft2(ifftshift(sampleMixedMag));

figure;
subplot(1, 2, 1);
imshow(real(capSampIm));
title('Capital Magnitude, Sample Phase');
subplot(1, 2, 2);
imshow(real(sampCapIm));
title('Sample Magnitude, Capital Phase');
disp('-----Finished Solving Problem 3.2-----');
pause;


close all;