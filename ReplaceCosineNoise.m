function [newMags] = ReplaceCosineNoise(oriMags, largestMags, indices)
n = length(largestMags(:));
newMags = oriMags;
for i=1:2:n-1
    row = indices(i,1);
    col = indices(i,2);
    conjRow = indices(i+1,1);
    conjCol = indices(i+1,2);
    avg = (oriMags(row-1,col-1) + oriMags(row-1,col) ...
        + oriMags(row-1,col+1) + oriMags(row,col-1) ...
        + oriMags(row,col+1) + oriMags(row+1,col-1) ...
        + oriMags(row+1,col) + oriMags(row+1,col+1)) / 8;
    newMags(row,col) = avg;
    newMags(conjRow,conjCol) = conj(avg);
end