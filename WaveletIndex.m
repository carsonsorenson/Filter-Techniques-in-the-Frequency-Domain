function [HLIndex, LHIndex, HHIndex] = WaveletIndex(C,L,n)
    index=prod(L(1,:));
    for i=2:length(L)-n-1
        index=index+(prod(L(i,:))*3);
    end
    bandSize=prod(L(length(L)-n,:));
    HLIndex=[index+1,index+bandSize];
    LHIndex=[index+bandSize+1,index+(2*bandSize)];
    HHIndex=[index+(2*bandSize)+1,index+(3*bandSize)];
end