function [edgelist,thinnedim]= edgeLinking(im_thinned)
    [~, ~, re, ce,thinnedim] = endsJunctions(im_thinned);
    [rim,cim]= size(thinnedim);
    [Ne,~] = size(re);
    rstart= re(1);
    cstart= ce(1);
    edgelist= [rstart cstart];
    roff = [-1  0  1  1  1  0 -1 -1];
    coff = [-1 -1 -1  0  1  1  1  0];
    r = rstart+roff;
    c = cstart+coff;
    mark= zeros(size(thinnedim));
    mark(rstart,cstart)=1;
    
    while true
        for i = 1:8
            r(i);
            if r(i)>0 && r(i)<=rim && c(i)>0 && c(i)<=cim && thinnedim(r(i),c(i))== 1 && mark(r(i),c(i))== 0
                edgelist = [edgelist
                            r(i) c(i)];
                                          
                mark(r(i),c(i))= 1;
                r= r(i)+ roff;
                c= c(i)+ coff;
                break
                
            elseif i==8 %encounter another endpoint
                
                min=Inf;
                rmin=0;
                cmin=0;
                for j= 1: Ne  %find a new endpoint near to the original one
                    if mark(re(j),ce(j))==0 && sqrt((re(j)-(r(i)+1))^2 + (ce(j)-c(i))^2) < min 
                        min= sqrt((re(j)-(r(i)+1))^2 + (ce(j)-c(i))^2);
                        rmin = re(j);
                        cmin = ce(j);
                                           
                    end
                end
                
                if rmin == 0 && cmin == 0 % no other endpoint, back to the start
                    edgelist = [edgelist
                                rstart cstart];
                    return
                else           %continue on the new endpoint
                    edgelist = [edgelist
                                rmin cmin];
                    mark(rmin,cmin)= 1;
                    r= rmin+ roff;
                    c= cmin+ coff;
                end
                
            end
            
        end
        
    end
    
    
end