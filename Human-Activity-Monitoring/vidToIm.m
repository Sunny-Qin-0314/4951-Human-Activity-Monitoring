%video to image
%inputs are strings
%path: path to where to save images
%vidFile: video name and .type
function workingDir = vidToIm(path,vidFile)
    workingDir = path;
    toMake = [workingDir 'images'];
    
    if exist(toMake, 'dir')
       status = rmdir(toMake,'s');
    end
    mkdir(toMake)
    
    %making a VideoReader
    shuttleVideo = VideoReader(vidFile);
    
    ii = 1;
    count = 1;
    %looping through video
    while hasFrame(shuttleVideo)
        img = readFrame(shuttleVideo);
       % if (mod(ii,2) = 0)
           % img = imresize(img,0.9,'nearest');
            filename = [sprintf('%03d',count) '.jpg'];
            count = count + 1;
            fullname = fullfile(workingDir,'images',filename);
            imwrite(img,fullname) %Writing to JPEG file
       % end
        
        ii = ii + 1;
    end
    
end