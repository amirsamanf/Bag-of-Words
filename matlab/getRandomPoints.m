function [points] = getRandomPoints(I, alpha)

[row, col, ~] = size(I);
points = zeros(alpha, 2);

for i = 1:alpha
    y = randi([1 row]);
    x = randi([1 col]);
    
    points(i, 1) = y;
    points(i, 2) = x;
end
