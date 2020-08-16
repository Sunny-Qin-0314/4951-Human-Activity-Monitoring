function [filter_x, filter_y] = GetDifferentialFilter()
    filter_x = [1,0,-1;2,0,-2;1,0,-1];  
    filter_y = [1,2,1;0,0,0;-1,-2,-1];   
end
