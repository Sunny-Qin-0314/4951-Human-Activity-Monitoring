function [EdgeImage] = EdgeDetection(i)
    % edge detection
%     I= imread(path);
%     i= rgb2gray(I);
    EdgeImage = edge (i,'sobel');
    imshow(EdgeImage);
end

