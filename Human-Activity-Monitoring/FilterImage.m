function [filteredImage]= FilterImage(i,filter)
    filteredImage= conv2(i,filter);
end
