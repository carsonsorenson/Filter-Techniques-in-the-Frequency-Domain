function [filteredIm, filter] = GaussianLowPassFilter(im)
fftIm = fft2(im);
fftImShift = fftshift(fftIm);

[m, n] = size(im);

centerU = floor(m / 2 + 1);
centerV = floor(n / 2 + 1);

uSigma = 25;
vSigma = 75;

filter = zeros(m, n);
for u=1:m
    for v=1:n
        exponent = (u-centerU)^2/(2*uSigma^2) + (v-centerV)^2/(2*vSigma^2);
        filter(u, v) = exp(-exponent);
    end
end

filteredImFft = fftImShift .* filter;
filteredImShift = ifftshift(filteredImFft);
filteredIm = uint8(ifft2(filteredImShift));
end