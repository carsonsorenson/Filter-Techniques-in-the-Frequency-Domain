function [magIm, largestMags, indices] = ComputeMagnitudes(im)
[rows, cols] = size(im);
magIm = abs(im);
[sortedMags, index] = sort(magIm(:), 'descend');

largestMags = zeros(8, 1);
indices = zeros(8, 2);
for i=2:9
    largestMags(i-1) = sortedMags(i);
    imRow = mod((index(i)-1),rows) + 1;
    imCol = floor((index(i)-1)/rows) + 1;
    indices(i-1,1) = imRow;
    indices(i-1,2) = imCol;
end