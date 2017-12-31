function survey_data_fillin(buoyNo,diskNo,frameSize,files,num)

% Get filelist for specified buoy and disk
fileList=dir(strcat('D:/Personal Folders/jlebien/DolphinData/Buoy',buoyNo));
fileList=extractfield(fileList,'name');
tmp=char(fileList);
fileList = fileList(tmp(:,end)==diskNo);

cs=[];
% nsaves=1;
% saveInterval=250; % number of iterations to force save
saveDir = strcat('D:/Personal Folders/jlebien/DolphinData/Buoy',buoyNo,'/Detections2/');
diary(strcat(saveDir,'textlog_',buoyNo,diskNo,'_',num2str(num),'.txt'));
diary on

tic
for i = files
    filePath=strcat('D:/Personal Folders/jlebien/DolphinData/Buoy',buoyNo,'/',fileList{i});
    try
        [time, signal]=readEARS(filePath);
    catch ME
        disp(ME)
        continue
    end
    [datenumber, ~] = readEARStimestamp(filePath);
    disp(datetime(datenumber,'ConvertFrom','datenum'));
    tmp = ce_dev(signal,time,frameSize,fileList{i});
%     plot_extracts(tmp,signal,time);
%     pause(2)
    if isempty(tmp)
        toc
        continue
    end
    if ~isempty(tmp(1).sig)
        if isempty(cs)
            cs=tmp;
            toc
            continue;
        else
            cs=[cs,tmp];
        end
    end
    toc
%     dt = whos('cs');
%     if (mod(i,saveInterval)==0 && i~=length(fileList)) || dt.bytes*9.53674e-7 > 1900
%         fprintf('\nSaving...\n\n')
%         save(strcat(saveDir,'detections_',buoyNo,diskNo,'_',num2str(nsaves),'.mat'),'cs')
%         diary off
%         nsaves=nsaves+1;
%         diary(strcat(saveDir,'textlog_',buoyNo,diskNo,'_',num2str(nsaves),'.txt'));
%         diary on
%         cs=[];
%     end
end

save(strcat(saveDir,'detections_',buoyNo,diskNo,'_',num,'.mat'),'cs')
diary off

% %--- Play Handel when finished
% load handel
% soundsc(y,Fs)
% clear y Fs
