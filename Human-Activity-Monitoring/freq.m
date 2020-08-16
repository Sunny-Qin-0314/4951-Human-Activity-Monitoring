y_track=0;
frame=0;
startpoint = false;
endpoint = false;

for eachframe
    x,y= pointTracking(im);
    if y> y_track && startpoint == false
        y_track=y;
        frame=1;
        startpoint=true;
    elseif y< y_track && endpoint==false
        period= (frame/15) *2;
        freq= 1/period;
        print out freq
        y_track= y;
        frame=frame+1;
        endpoint=true;
    elseif y>y_track && startpoint ==true
        frame= frame +1;
        y_track=y;
    else
        frame= frame +1;
        y_track=y;
        
            
    end
end
