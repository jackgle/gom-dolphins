function [dcounts,dtbins] = count_dols_hour(diskNo)
%%% This script will read the stored detection results, and count the
%%% number of dolphins clicks within time windows of 1 hour

buoyNo='04';
    
fprintf('\n%s%s','Disk number... ',num2str(diskNo));

%--- get filelist
fileList=dir(strcat('D:/Personal Folders/jlebien/DolphinData/Buoy',buoyNo,'/Detections/'));
fileList=extractfield(fileList,'name');
fileList=fileList(3:end);
fileList=char(fileList);
fileList=fileList(fileList(:,1)=='d',:);
fileList=fileList(fileList(:,14)==num2str(diskNo),:);
fileList=cellstr(fileList);
fileList=natsortfiles(fileList);

fprintf('\n%s','Generating date-time array...');

load(fileList{1})
t1 = datetime(readEARStimestamp(cs(1).filename),'ConvertFrom','datenum');
t1 = dateshift(t1,'start','hour');
load(fileList{end})
t2 = datetime(readEARStimestamp(cs(end).filename),'ConvertFrom','datenum');
t2 = dateshift(t2,'start','hour');


dtbins = t1:hours(1):t2;
dcounts = zeros(length(dtbins),1);
k=1;

%--- loop over filelist
for ii=1:length(fileList)

    %--- load the click structure, and the associated 
    %--- classification results
    fprintf('\n\t%s%s','File... ',fileList{ii});
    load(fileList{ii});
    load(strcat(strtok(fileList{ii},'.'),'_stage1.mat'));
    
    %--- reduce the structure to only dolphin clicks
    cs = cs(isdol==1); 

    %--- loop through structure
    for jj=1:length(cs)

        t2 = datetime(readEARStimestamp(cs(jj).filename),'ConvertFrom','datenum'); % get the timestamp of the current click

        if t2 < dtbins(k+1)  % if it is within the hour of the current bin, increase the count by 1
            dcounts(k)=dcounts(k)+1;
        else    % if not, increment the bin number
            tmp=find(dtbins>t2);
            if isempty(tmp)
                break
            end
            k=tmp(1)-1;
            dcounts(k)=1;
        end
    end

end

fprintf('\n');

dcounts=dcounts(~isnan(dcounts));
dtbins=dtbins(year(dtbins)>0001);