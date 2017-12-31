%%% Download generated file list from ftp server

tic; % start timer
%--- Open ftp connection to server
f = ftp('phys-ladc-store.louisiana.edu','ul-phys-user','uluser.ftp');
cd(f); sf = struct(f); %sf.jobject.enterLocalPassiveMode();

%--- Get list of existing files
presentFiles=ls('D:/Personal Folders/jlebien/DolphinData/Buoy04/');
presentFiles=cellstr(presentFiles);
fileList = setdiff(fileList, presentFiles);

%--- Initialize tmp variable and current dat
tmp=0;
dt = datetime('now');

%--- Loop over names in fileList
for i = 1:2
% for i = 1:length(fileList)
%     % Missing data for Buoy01: Disks 1 and 2
%     if fileList{i}(end) == '1' || fileList{i}(end) == '2'
%         continue
%     end
    curfile = fileList{i};
    
    clc;fprintf('%s %s\r\n','Getting file...',curfile);
    
    %--- Check if file already exists locally
    if any(strcmp(presentFiles,curfile))
%         fprintf('%s \r\n','File exists')
        continue
    end

    %--- Print download stats to screen
    fprintf('%s %s %s%.3f%s %s%.3f %s\r\n','File',  strcat(num2str(i),'/',num2str(length(fileList))),...
                                                    '(',i*100/length(fileList),'%)',...
                                                    '(',8192/(toc-tmp),'KiB/s)');
    %--- Estimate time remaining and print                               
    timermn=(((length(fileList)-i)*8192)/(8192/(toc-tmp)))/3600;                                                                               
    fprintf('%s %.3f\n%s\n%s %.2f','Runtime (hr): ',toc/3600,dt,'Est. Time Remaining (hr):',timermn);
    
    %--- Get directory of current file
    filePath = strcat('/Volumes/FirstRAID/Buoy',curfile(end-2:end-1),'_DISK',curfile(end),'/');
    
    %--- Check if directory changed, if so, then cd
    if length(filePath)~=length(cd(f)) || filePath~=cd(f)
        cd(f,filePath);
    end
    
    %--- Get current runtime
    tmp=toc;
    
    %--- Attempt to retrieve file, if it fails, close and reopen connection 
    %and try again (5 times max)
    for tr = 1:6
        try
            if tr>5
                return
            end
            mget(f,curfile,strcat('D:/Personal Folders/jlebien/DolphinData/Buoy',curfile(end-2:end-1),'/'));
            break;
        catch ME
            breaks=breaks+1;
            disp(dt);
            disp(ME);
            close(ftp)
            f = ftp('phys-ladc-store.louisiana.edu','ul-phys-user','uluser.ftp');
        end
    end
            
    % Every ten files, print the current datetime to screen
    if mod(i,10)==0
        dt = datetime('now');
    end
%     if mod(i,50)==0
%         connect(f)
%     end
    
end

% Close connection and print total runtime
fprintf('\r\n\r\n')
clear filePath ans tmp timermn sf tr
close(f)
runtime=toc;

%--- Play Handel when finished
load handel
soundsc(y,Fs)
clear y Fs

