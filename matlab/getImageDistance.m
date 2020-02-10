function [dist] = getImageDistance(hist1, hist2, method)

n = length(hist1);
if strcmp('chi2', method)
    % CHI2
    sum = 0;
    for i = 1:n
        num = (hist1(i) - hist2(i))^2;
        den = hist1(i) + hist2(i); 
        sum = sum + (num/(den+eps));
    end
    dist = sum / 2;

else
    % EUCLIDEAN
    dist = pdist2(hist1, hist2, 'euclidean');
end



    
    
    
    
    
    
    



