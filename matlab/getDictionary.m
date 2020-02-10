function [dictionary] = getDictionary(imgPaths, alpha, K, method)


filterBank = createFilterBank();
pixelResponses = zeros(alpha*length(imgPaths), 3*length(filterBank));

for k = 1:length(imgPaths)
    im = imread(strcat('../data/', cell2mat(imgPaths(k))));
    if (ndims(im) ~= 3)
        im = cat(3, im, im, im);
    end
    
    imdouble = double(im);
    
    Lab = RGB2Lab(imdouble(:,:,1), imdouble(:,:,2), imdouble(:,:,3));
    response = extractFilterResponses(Lab, filterBank);


    for j = 1:size(response, 3)

        if strcmp('random', method)
            points = getRandomPoints(response(:,:,j), alpha);
        else
            points = getHarrisPoints(response(:,:,j), alpha, 0.04);
        end

        ptr = k*length(points)-length(points);
        for i = 1:length(points)
            pixelResponses(i+ptr,j) = response(points(i,1), points(i,2), j);
        end

    end
end

[~, dictionary] = kmeans(pixelResponses, K, 'EmptyAction', 'drop');



