function stage1_class(buoyNo,diskNo)

Fs=192000;
fileList=dir(strcat('D:/Personal Folders/jlebien/DolphinData/Buoy',buoyNo,'/Detections'));
mkdir(strcat('D:/Personal Folders/jlebien/DolphinData/Buoy',buoyNo,'/Detections/Stage1/'));
fileList=extractfield(fileList,'name');
fileList=fileList(3:end);
fileList=char(fileList);
fileList=fileList(fileList(:,1)=='d',:);
fileList=fileList(fileList(:,14)==diskNo,:);
fileList=cellstr(fileList);
fileList=natsortfiles(fileList);

for ii = 1:length(fileList)
    clear cs
%     flname = strcat('detections_',buoyNo,diskNo,'_',num2str(ii));
    flname=fileList{ii};
    fprintf('Loading %s...\n',flname);
    load(strcat('D:/Personal Folders/jlebien/DolphinData/Buoy',buoyNo,'/Detections/',flname));
    
    fprintf('Processing %s...\n',flname);
    isdol = zeros(length(cs),1);
    fmat = zeros(length(cs),7);
    tic
    for jj = 1:length(cs)
        [isdol(jj),fmat(jj,:)] = isdolphin_caruso(cs(jj).sig,Fs);
    end
    toc
    fprintf('\n');
    save(strcat('D:/Personal Folders/jlebien/DolphinData/Buoy',buoyNo,'/Detections/Stage1/',strtok(flname,'.'),'_stage1','.mat'),'isdol','fmat');
end

%--- Play Handel when finished
% load handel
% soundsc(y,Fs)
% clear y Fs