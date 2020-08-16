function[final_image]=expandAndThinning(gapsize,thinned_im)
    for i = 1: gapsize
        [thinned_im,edgelist]= expand(thinned_im);
    end
    [final_image]= edgethinning(thinned_im);
end