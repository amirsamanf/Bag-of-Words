function [filterResponses] = extractFilterResponses(I, filterBank)

filterResponses = zeros(size(I,1), size(I, 2), 3*size(filterBank, 1));

L = I(:,:,1); a = I(:,:,2); b = I(:,:,3);

j = 1;
for i = 1:size(filterBank, 1)
    
    h = cell2mat(filterBank(i));
    Lf = imfilter(L,h,'replicate');
    af = imfilter(a,h,'replicate');
    bf = imfilter(b,h,'replicate');

    filterResponses(:,:,j:j+2) = cat(3, Lf, af, bf);
    j = j + 3;
end