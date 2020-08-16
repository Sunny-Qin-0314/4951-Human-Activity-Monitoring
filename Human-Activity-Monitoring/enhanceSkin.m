function [output_im]= enhanceSkin(rgb_im)

    hsv= rgb2hsv(rgb_im);
    h= hsv(:,:,1);
    s= hsv(:,:,2);
    v= hsv(:,:,3);
    
    hBinary= h<0.08; % threshold 
    sBinary= s>0.20;
    vBinary= v>0.50;
    
    output_im= hBinary & sBinary & vBinary; % combine to binary image
    
    
    imshow(output_im);
end