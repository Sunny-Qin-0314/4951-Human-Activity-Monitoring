function [rj, cj, re, ce,thinnedim] = endsJunctions(b)

    
    % Set up look up table to find junctions.  To do this we use the function
    % defined at the end of this file to test that the centre pixel within a 3x3
    % neighbourhood is a junction.
    lut = makelut(@junction, 3);
    junctions = applylut(b, lut);
    [rj,cj] = find(junctions);
    
    %remove junction point and do edge thinning again to remove isolated
    %line
       
     Nj= size(rj); 
     if Nj > 0 
        for i = 1: Nj
          b(rj(i),cj(i))= 0;
        end
        rj=0;
        cj=0;
        thinnedim= edgethinning(b);
     else
        thinnedim = b;
     end
    % Set up a look up table to find endings.  
    lut = makelut(@ending, 3);
    ends = applylut(thinnedim, lut);
    [re,ce] = find(ends);    

       
	imshow(thinnedim), hold on
	plot(cj,rj,'r+')
	plot(ce,re,'g+')    
    
    %----------------------------------------------------------------------
% Function to test whether the centre pixel within a 3x3 neighbourhood is a
% junction. The centre pixel must be set and the number of transitions/crossings
% between 0 and 1 as one traverses the perimeter of the 3x3 region must be 6 or
% 8.
%
% Pixels in the 3x3 region are numbered as follows
%
%       1 4 7
%       2 5 8
%       3 6 9

function b = junction(x)
    
    a = [x(1) x(2) x(3) x(6) x(9) x(8) x(7) x(4)]';
    b = [x(2) x(3) x(6) x(9) x(8) x(7) x(4) x(1)]';    
    crossings = sum(abs(a-b));
    
    b = x(5) && crossings >= 6;
    
%----------------------------------------------------------------------
% Function to test whether the centre pixel within a 3x3 neighbourhood is an
% ending. The centre pixel must be set and the number of transitions/crossings
% between 0 and 1 as one traverses the perimeter of the 3x3 region must be 2.
%
% Pixels in the 3x3 region are numbered as follows
%
%       1 4 7
%       2 5 8
%       3 6 9

function b = ending(x)
    a = [x(1) x(2) x(3) x(6) x(9) x(8) x(7) x(4)]';
    b = [x(2) x(3) x(6) x(9) x(8) x(7) x(4) x(1)]';    
    crossings = sum(abs(a-b));
    
    b = x(5) && crossings == 2;
    


