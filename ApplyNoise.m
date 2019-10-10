function [noisyIm, filter] = ApplyNoise(im)
fftImShift = fftshift(fft2(im));
[m, n] = size(im);
centerU = floor(m / 2 + 1);
centerV = floor(n / 2 + 1);

filter = zeros(m,n);
k = 0.0025;

for u=1:m
    for v=1:n
        D_u_v = sqrt((u-centerU)^2 + (v-centerV)^2);
        val = exp(-k*(D_u_v^(5/3)));
        filter(u,v) = val;
    end
end

filteredImFft = fftImShift .* filter;
filteredImFftShift = ifftshift(filteredImFft);
noisyIm = uint8(ifft2(filteredImFftShift));
end