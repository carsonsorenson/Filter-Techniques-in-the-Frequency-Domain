function [restoredIm] = WienerFilter(im)
fftImShift = fftshift(fft2(im));
[m, n] = size(im);
centerU = floor(m / 2 + 1);
centerV = floor(n / 2 + 1);

k = 0.0025;
g = 0.00035;

filteredIm = zeros(m, n);
for u=1:m
    for v=1:n
        duv = sqrt((u-centerU)^2 + (v-centerV)^2);
        huv = exp(-k*(duv^(5/3)));
        filteredIm(u,v) = ((1 / huv) * (abs(huv)^2/ (abs(huv)^2 + g))) * fftImShift(u,v);
    end
end
restoredIm = uint8(ifft2(ifftshift(filteredIm)));
end
