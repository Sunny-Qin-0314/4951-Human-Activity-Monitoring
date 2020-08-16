function [ThinnedImage]= edgethinning(EdgeImage)
%edge thinning 
    i= bwmorph(EdgeImage,'clean', Inf); %clean isolated edge pixels
    i= bwmorph(i,'thin', Inf);  % thin the edge
    ThinnedImage= bwareaopen(i,80);  %remove small object(<100 pixels)
    %ThinnedImage = bwperim(ThinnedImage,8);
    imshowpair(EdgeImage,ThinnedImage,'montage');
end
