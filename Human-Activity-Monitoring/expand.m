function [expandedImage,edgelist]= expand(im)
    [edgelist, thinnedim]= edgeLinking(im);
    [Ne,~] = size(edgelist);
    [maxr,maxc]= size(thinnedim);
    
    roff = [-1  0  1  1  1  0 -1 -1];
    coff = [-1 -1 -1  0  1  1  1  0];
    
    for i=1: Ne
        
            rstart= edgelist(i,1);
            cstart= edgelist(i,2);
            r= rstart + roff;
            c= cstart + coff;
            for j= 1: 8
                if r(j)>0 && r(j)<=maxr && c(j)>0 && c(j)<=maxc && thinnedim(r(j),c(j))==0
                    thinnedim(r(j),c(j))=1;
                end
            end
        
    end
    expandedImage=thinnedim;
    imshow(expandedImage);
end