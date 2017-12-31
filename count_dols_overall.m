buoyNo='04';
diskNo='0';

fileList=dir(strcat('D:/Personal Folders/jlebien/DolphinData/Buoy',buoyNo,'/Detections/Stage1/'));
fileList=extractfield(fileList,'name');
fileList=fileList(3:end);
fileList=char(fileList);
fileList=fileList(fileList(:,1)=='d',:);
fileList=fileList(fileList(:,14)==diskNo,:);

fileList2=dir(strcat('D:/Personal Folders/jlebien/DolphinData/Buoy',buoyNo));
fileList2=extractfield(fileList2,'name');
tmp=char(fileList2);
fileList2 = fileList2(tmp(:,end)==diskNo);

fprintf('\nCounting detections...')
countPos=0;
countNeg=0;
for ii=1:length(fileList)
    flname=strcat('detections_',buoyNo,diskNo,'_',num2str(ii),'_stage1');
    load(strcat('D:/Personal Folders/jlebien/DolphinData/Buoy',buoyNo,'/Detections/Stage1/',flname,'.mat'));
    countPos = countPos+length(find(isdol==1));
    countNeg = countNeg+length(find(isdol==0));
end

fprintf('\nGetting timestamps...\n')
[t1, ~] = readEARStimestamp(strcat('D:/Personal Folders/jlebien/DolphinData/Buoy',buoyNo,'/',fileList2{1}));
[t2, ~] = readEARStimestamp(strcat('D:/Personal Folders/jlebien/DolphinData/Buoy',buoyNo,'/',fileList2{end}));
   
t1=datetime(t1,'ConvertFrom','datenum');
t2=datetime(t2,'ConvertFrom','datenum');
t2=t2+seconds(21.33333333);