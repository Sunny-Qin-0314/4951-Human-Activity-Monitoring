function [grad_mag, grad_angle] = GetGradient(im_dx, im_dy)
    grad_mag= sqrt(im_dx.^2 + im_dy.^2);
    grad_angle= atan2(im_dy, im_dx);
    [m,n] = size(grad_angle);
    for i= 1:m 
        for j= 1:n
            if grad_angle(i,j)<0 
                grad_angle(i,j)= grad_angle(i,j)+ 3.1416;
            end
        end
    end
end