function [newC] = RemoveWhiteNoise(C,L,n)
newC = C;

% get the correct subband
[HL,LH,HH] = WaveletIndex(C,L,n);
subband = C(HL(1):HH(2));
M = numel(subband);

% 3- Estimate the noise variance
sigma = sqrt(median(abs(subband)) / 0.6745);

% 4- Compute the adaptive threshold
t = sigma * sqrt(2*log(M));

% 5- Modify the wavelet coefficient
for i=1:M
    if subband(i) >= t
        subband(i) = subband(i) - t;
    elseif subband(i) <= -t
        subband(i) = subband(i) + t;
    elseif abs(subband(i)) < t
        subband(i) = 0;
    end
end

newC(HL(1):HH(2)) = subband;
end