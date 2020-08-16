function [output] = Main(path)
    I=imread(path);
    I= im2double(I);
    I= rgb2gray(I);
    [filter_x, filter_y] = GetDifferentialFilter();
    im_dx= FilterImage(I, filter_x);
    im_dy= FilterImage(I, filter_y);
    [grad_mag, grad_angle] = GetGradient(im_dx, im_dy);
    imshow(grad_mag);
   
end
