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
imshow(uint8(capSampIm*255));
%imshow(real(capSampIm));
title('Capital Magnitude, Sample Phase');
subplot(1, 2, 2);
imshow(uint8(sampCapIm*255));
%imshow(real(sampCapIm));
title('Sample Magnitude, Capital Phase');
disp('-----Finished Solving Problem 3.2-----');
pause;

boyIm = imread('boy_noisy.gif');
boyImDouble = im2double(boyIm);
fftBoyIm = fftshift(fft2(boyImDouble));

% Calculate the image magnitude, 4 largest distinct magnitudes, and indices
% where those magnitudes are
[fftBoyImMag, largestMags, indices] = ComputeMagnitudes(fftBoyIm);

% Replace the largest magnitudes with the average of its neighbors
% magnitudes to remove noise
[newMags] = ReplaceCosineNoise(fftBoyImMag, largestMags, indices);

fftFixedBoyIm = newMags .* exp(1i * angle(fftBoyIm));
fixedBoyIm = ifft2(ifftshift(fftFixedBoyIm));

figure;
subplot(1, 2, 1);
imshow(boyIm);
title('Original Boy Image');
subplot(1, 2, 2);
imshow(fixedBoyIm);
title('Filtered Boy Image');

disp('-----Finished Solving Problem 4-----');
pause;

lenaIm = imread('Lena.jpg');
dwtmode('per');
n = wmaxlev(size(lenaIm),'db2');
[C,L] = wavedec2(lenaIm,n,'db2');
restoredLena = uint8(waverec2(C,L,'db2'));
if isequal(restoredLena,lenaIm)
    disp('The two images are the same');
else
    disp('The two images are different');
end

disp('-----Finished Solving Problem 5.1-----');
pause;

%apply 3-level db2 wavelet decomposition
[C, L] = wavedec2(lenaIm,3,'db2');

% set the four values of each 2x2 non-overlapping block in the
% approximation subband as its average
A3 = appcoef2(C,L,'db2',3);
[rows,cols] = size(A3);
for i=1:2:rows
    for j=1:2:cols
        block=A3(i:i+1,j:j+1);
        avg=sum(block(:))/numel(block);
        A3(i:i+1,j:j+1)=avg;
    end
end
newA3=reshape(A3,[1,numel(A3)]);
C1=C;
C1(1:prod(L(1,:)))=newA3;
lenaIm1 = waverec2(C1,L,'db2');
figure;
imshow(uint8(lenaIm1));
title('Average approximation subband');

% set the first level vertical detail coefficients as 0's
[HL1,LH1,HH1] = WaveletIndex(C,L,1);
C2 = C;
C2(LH1(1):LH1(2))=0;
lenaIm2 = waverec2(C2,L,'db2');
figure;
imshow(uint8(lenaIm2));
title('First Level Vertical Detail at 0');

% set the third level horizontal detail coefficients as 0's
[HL3,LH3,HH3] = WaveletIndex(C,L,3);
C3 = C;
C3(HL3(1):HL3(2))=0;
lenaIm3 = waverec2(C3,L,'db2');
figure;
imshow(uint8(lenaIm3));
title('Third Level Horizontal Detail at 0');

disp('-----Finished Solving Problem 5.2-----');
pause;

% 1- Call imnoise to add Gaussian white noise
noisyLena = imnoise(lenaIm,'gaussian',0,0.01);

% 2- Apply a 3-level db2 wavelet decomposition
dwtmode('per');
[C,L] = wavedec2(noisyLena,3,'db2');

% 3,4,5 - Handled by the function RemoveWhiteNoise
newC1 = RemoveWhiteNoise(C,L,1);

% 6- Apply steps 3,4,5 on 2nd level subband
newC2 = RemoveWhiteNoise(newC1,L,2);

% 7- Apply steps 3,4,5 on 3rd level subband
newC3 = RemoveWhiteNoise(newC2,L,3);

% 8- Take the inverse wavelet transform to get denoised image
recLena = waverec2(newC3,L,'db2');

% 9- Display the noisy image and the denoised image side-by-side
figure;
subplot(1,2,1);
imshow(noisyLena);
title('Noisy Image');
subplot(1,2,2);
imshow(uint8(recLena));
title('Denoised Image');

disp('-----Finished Solving Problem 6-----');
pause;

clear;
close all;