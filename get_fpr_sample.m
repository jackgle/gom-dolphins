%%% Collect 1000 random clicks determined to be dolphins

clear

buoyNo='04'; % set buoy of interest

%--- get list of detection files from this buoy
fileList=dir(strcat('D:/Personal Folders/jlebien/DolphinData/Buoy',buoyNo,'/Detections/'));
fileList=extractfield(fileList,'name');
fileList=fileList(3:end);
fileList=char(fileList);
fileList=fileList(fileList(:,1)=='d',:);
fileList=cellstr(fileList);
fileList=natsortfiles(fileList);

%--- randomly sample 100 detection files
smpl = randsample(length(fileList),100);
smpl = fileList(smpl);

smpl_cs=[];

%--- loop over sample files
for ii = 1:length(smpl)
    
    clear cs isdol fmat
    %--- load the detection structure, and the associated classification results
    fprintf('\n\t%s%s','File... ',smpl{ii});
    load(smpl{ii});
    load(strcat(strtok(smpl{ii},'.'),'_stage1.mat'));
    
    %--- reduce detected clicks structure to only dolphin clicks
    cs = cs(isdol==1);
    
    %--- append 10 random dolphin clicks to the sample click structure
    smpl_cs=[smpl_cs,cs(randsample(1:length(cs),10))];
end

