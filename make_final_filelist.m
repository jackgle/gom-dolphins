%%% Determines further needed files from the time span of events beginning in
%%% existing files
%%%


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

%--- Define the amount of time a file spans
fileT = 21.3333333333333;

fileList={}; % empty array for filenames (fix me?)
fileList_neededmore={};
len=length(events_flt);
prog = '';
bar = pad(prog,20,' ');
k=1;
l=1;
tic
clc;fprintf('%s%s%s\r\n','|',bar,'|');
for i = 1:len % loop over events
    %--- Progress Bar
    if round(i/len*20) > round((i-1)/len*20)
        prog = strcat(prog,'=');
        bar = pad(prog,20,'right',' ');
        clc;fprintf('%s\r\n%s%s%s\r\n','Saving file names...','|',bar,'|');
    end
    
    fileList{k}=events_flt(i).filename; % append current filename to list
    startTime = events_flt(i).startRecord*250/192000; % get start time of event (there are 250 samples per record)
    endTime =   startTime + events_flt(i).duration_seconds; % compute end time
    evntNumFiles = ceil(endTime/21.3333333); % get the number of files the event spans (rounded up to integer)
    k = k+1;
    if evntNumFiles > 1 
        tmp = events_flt(i).filename; % get current filename
        %--- To debug
        fileList_neededmore{l}=events_flt(i).filename;
        l=l+1;
        %---
        filenum = tmp(5:8); % hex file number
        dy = str2double(tmp(2:4));
        dt1 = readEARStimestamp(tmp); % get datetime of start of current file
        dt1 = datetime(dt1,'ConvertFrom','datenum');
        %--- Generate filenames for rest of event
        dt2 = dt1;
        for j = 1:evntNumFiles
            dt2 = dt2+seconds(fileT); % add 21.33 seconds to the datetime
            filenum = hex2dec(filenum); % convert hex filenumber to integer
            filenum=filenum+1; % add 1 to filenumber
            if day(dt2) > day(dt1)
                dy = dy+1; % if the day increased after 21.33 seconds, increment day
            end 
            if filenum > 65535 % if the filenum exceeds FFFF after increment, reset to zero
                filenum = 0;
            end
            filenum = dec2hex(filenum); % convert filenumber to hexadecimal
            if length(filenum)<4 
                filenum=pad(filenum,4,'left','0'); % pad filenum to be four characters if necessary
            end
            fileList{k} = strcat('5',num2str(dy),filenum,events_flt(i).filename(end-3:end)); % append filename
            k = k+1; % increment counter
        end
    end
end
toc

%--- Filter out any files that already exist locally from the download list
fileList = setdiff(fileList, presentFiles);

fileList=unique(fileList); % make sure list elements are unique
clear tmp i j k dt1 dt2 dy endTime startTime fileT filenum evntNumFiles len prog bar; % clear memory

%--- Play gong when finished
load gong
soundsc(y,Fs)
clear y Fs

