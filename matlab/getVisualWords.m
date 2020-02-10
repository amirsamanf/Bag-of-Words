function [wordMap] = getVisualWords(I, filterBank, dictionary)

im = I;
if (ndims(im) ~= 3)
    im = cat(3, im, im, im);
end

imdouble = double(im);
Lab = RGB2Lab(imdouble(:,:,1), imdouble(:,:,2), imdouble(:,:,3));
response = extractFilterResponses(Lab, filterBank);
reshapedResponse = reshape(response,[],3*length(filterBank));

[~, map] = pdist2(dictionary, reshapedResponse, 'euclidean', 'Smallest', 1);

wordMap = reshape(map,size(im, 1), size(im, 2), []);