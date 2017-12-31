%%% Get filenames from ULL results for a given buoy, set of band codes, and
%%% # of clicks threshold

clc;fprintf('%s\r\n','Filtering raw events structure...');

%--- Load the .mat file containing the ULL detection results in structure
%array format
load('D:/Data/META/ULL Detection Results/Buoy04_AllDisks.mat')
%--- Get list of existing files
presentFiles=ls('D:/Personal Folders/jlebien/DolphinData/Buoy04/');
presentFiles=cellstr(presentFiles);

%--- Set the band codes of interest in ULL results (see plotclickcounts.m)
bands=[3,5,7];

%--- Set the minimum number of clicks of interest for an event
cthresh=2;

%--- Reduce the initial structure to the entries which satisfy the provided
%criteria (using function detection_filt())
events_flt = detection_filt(events,bands,cthresh);
clear events

fileList={}; % empty array for filenames (fix me?)
len=length(events_flt);
prog = '';
bar = pad(prog,20,' ');
k=1;
tic
clc;fprintf('%s%s%s\r\n','|',bar,'|');
for i = 1:len % loop over events
% for i = 1:20
    if round(i/len*100/5) > round((i-1)/len*100/5)
        prog = strcat(prog,'=');
        bar = pad(prog,20,'right',' ');
        clc;fprintf('%s\r\n%s%s%s\r\n','Saving file names...','|',bar,'|');
    end
    fileList{k}=events_flt(i).filename; % append current filename to list
    k = k+1;

end
toc

fileList=unique(fileList); % make sure list elements are unique

%--- Filter out any files that already exist locally from the download list
fileList = setdiff(fileList, presentFiles);

clear tmp i j k dt1 dt2 dy endTime startTime fileT filenum evntNumFiles len prog bar; % clear memory

%--- Play gong when finished
load gong
soundsc(y,Fs)
clear y Fs