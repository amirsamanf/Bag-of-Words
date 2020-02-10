function [ h ] = getImageFeatures(wordMap, dictionarySize)

h = zeros(1, dictionarySize);

for i = 1:size(wordMap, 1)
    for j = 1:size(wordMap, 2)
        word = wordMap(i,j);
        h(word) = h(word) + 1;
    end
end

h = h/norm(h,1);