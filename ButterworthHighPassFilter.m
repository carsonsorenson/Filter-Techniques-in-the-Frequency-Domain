function [filteredIm, filter] = ButterworthHighPassFilter(im)
fftIm = fft2(im);
fftImShift = fftshift(fftIm);

[m, n] = size(im);
centerU = floor(m / 2 + 1);
centerV = floor(n / 2 + 1);

filter = zeros(m, n);

filterOrder = 2;
D_0 = 40;
for u=1:m
    for v=1:n
        D_u_v = sqrt((u-centerU)^2 + (v-centerV)^2);
        val = 1 / (1 + (D_0 / D_u_v)^(2*filterOrder));
        filter(u,v) = val;
    end
end

filteredImFft = fftImShift .* filter;
filteredImFftShift = ifftshift(filteredImFft);
filteredIm = uint8(ifft2(filteredImFftShift));
end