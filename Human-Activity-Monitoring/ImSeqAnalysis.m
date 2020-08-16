%path should be full path to where folder of images saved
%VidFile is full vid title with a .type. This should be saved where the
%code is running from, or include path in title 
%output is what to name output file
%all of these are strings

function [imageNames,outputVideo,imCell,freq] = ImSeqAnalysis(path,vidFile,output)
 
workingDir = path;
shuttleVideo = VideoReader(vidFile);

imageNames = dir(fullfile(workingDir,'images','*.jpg'));
imageNames = {imageNames.name};

outputVideo = VideoWriter(fullfile(workingDir,output));
framerate = shuttleVideo.FrameRate;
outputVideo.FrameRate = framerate*0.5; 
open(outputVideo) 

imCell = {};

parfor ii = 1:length(imageNames)
   tempimg = imread(fullfile(workingDir,'images',imageNames{ii}));
  % tempimg = imresize(tempimg,0.67,'nearest');
   final_image = enhanceSkin(tempimg);
  % tempimg = rgb2gray(tempimg);
   %EdgeImage = edgeDetection(double(tempimg));
   % im_thinned = edgethinning(EdgeImage);
   % final_image = expandAndThinning(1,im_thinned);
 imCell(ii) = {double(final_image)};
  %  imCell(ii) = {double(final_image)};
end

[freq,imCell] = freqCalculator(imCell,framerate);

for ii = 1:2:length(imageNames)
   writeVideo(outputVideo,cell2mat(imCell(ii))); 
end



end

function [avgfreq,imCell] = freqCalculator(imCell,framerate)

szimCell = size(imCell);
y_track=0;
frame=1;
startpoint = false;
endpoint = true;
allfreqs = [];
%TODO: need to fix startpoint issue
for i = 1:szimCell(2)
    y= pointTracking(imCell{i});
    freq = [0];
    if y> (y_track+10) && startpoint == false
        y_track=y;
        frame=1;
        startpoint=true;
        endpoint = false;
    elseif y< (y_track-10) && endpoint==false
        period= (frame/framerate) * 2;
        freq= 1/period;
        allfreqs = [allfreqs freq];
        %keyboard
       % printout freq
       position = [50 100];
        imCell{i} = insertText(imCell{i},position,['Frequency: ' num2str(allfreqs(end))],...
            'FontSize',60,'BoxColor','black','TextColor','white','AnchorPoint','LeftBottom');
        y_track= y;
        frame=frame+1;
        endpoint=true;
        startpoint = false;
    else
        frame= frame +1;
        y_track=y;
        position = [50 100];
        if ~isempty(allfreqs)
           imCell{i} = insertText(imCell{i},position,['Frequency: ' num2str(allfreqs(end))],...
                'FontSize',60,'BoxColor','black','TextColor','white','AnchorPoint','LeftBottom');
        else
            imCell{i} = insertText(imCell{i},position,['Frequency: -- '],...
                'FontSize',60,'BoxColor','black','TextColor','white','AnchorPoint','LeftBottom');
       
        end

            
    end
end
%deleting first element because it could have errors
allfreqs(1) = [];
%allfreqs(2) = [];
avgfreq = mean(allfreqs);
%keyboard
end

function col = pointTracking(im)
%TODO: need to make these changeable
   [row,col] = find(im(360:560,:),1,'first');
   %360 to 560
   %1 to 400
end
%shuttleAvi = VideoReader(fullfile(workingDir,'shuttle_out2.mov'));

%ii = 1;
%while hasFrame(shuttleAvi)
%   mov(ii) = im2frame(readFrame(shuttleAvi));
%   ii = ii+1;
%end