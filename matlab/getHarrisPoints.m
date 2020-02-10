function [points] = getHarrisPoints(I, alpha, k)

im = I;
if (ndims(I) == 3)
    im = rgb2gray(I);
end

sigma = 0.5;
hsize = 2 * ceil(3 * sigma) + 1;

kSmooth = fspecial('gaussian',hsize,sigma);    
kHoriz = double([1,0,-1;2,0,-2;1,0,-1]);
kVert = double([1,2,1;0,0,0;-1,-2,-1]);

smoothed = imfilter(im, kSmooth, 'replicate');    
imgx = imfilter(smoothed, kHoriz, 'replicate');
imgy = imfilter(smoothed, kVert, 'replicate');

% remove border gradient
imgx(:,1:2) = 0;
imgx(:,end-1:end) = 0;
imgx(1:2,:) = 0;
imgx(end-1:end,:) = 0;
imgy(:,1:2) = 0;
imgy(:,end-1:end) = 0;
imgy(1:2,:) = 0;
imgy(end-1:end,:) = 0;

Ix2 = imgx .^ 2;
Ixy = imgx .* imgy;
Iy2 = imgy .^ 2;

[row, col] = size(imgx);
K = zeros(row, col);
for i = 2:row-1
    for j = 2:col-1
        sx2 = 0; sxy = 0; sy2 = 0;
        for krow = -1:1
            for kcol = -1:1
                sx2 = sx2 + Ix2(i+kcol,j+krow);
                sxy = sxy + Ixy(i+kcol,j+krow);
                sy2 = sy2 + Iy2(i+kcol,j+krow);
            end
        end
        
        M = [sx2, sxy; sxy, sy2];
        R = det(M) - (k * (trace(M).^2));
        K(i, j) = R;
    end
end

maxInd = imregionalmax(K);
K(maxInd ~= 1) = 0;

countNonZero = nnz(K);
if countNonZero < alpha
    [~, Ind] = sort(K(:),1,'descend');
    [ind_row, ind_col] = ind2sub(size(K),Ind(1:countNonZero));
else
    [~, Ind] = sort(K(:),1,'descend');
    [ind_row, ind_col] = ind2sub(size(K),Ind(1:alpha));
end

points = [ind_row ind_col];






