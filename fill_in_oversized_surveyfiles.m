% detections_041_47.mat
% detections_041_96.mat
% detections_041_105.mat
% detections_041_107.mat
% detections_041_108.mat
% detections_042_54.mat
% detections_042_118.mat

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% buoyNo='04';
% diskNo='1';
% % Get filelist for specified buoy and disk
% fileList=dir(strcat('D:/Personal Folders/jlebien/DolphinData/Buoy',buoyNo));
% fileList=extractfield(fileList,'name');
% tmp=char(fileList);
% fileList = fileList(tmp(:,end)==diskNo);

%%
% fprintf('\n%s\n','File... detections_041_47.mat');
% load('detections_041_46.mat')
% file1 = cs(end).filename;
% file1 = find(strcmp(cellstr(fileList),file1));
% load('detections_041_48.mat')
% file2 = cs(1).filename;
% file2 = find(strcmp(cellstr(fileList),file2));
% 
% files = file1+1:file2-1;
% 
% survey_data_fillin(buoyNo,diskNo,111,files(1:floor(end/2)),'47_1');
% survey_data_fillin(buoyNo,diskNo,111,files(floor(end/2)+1:end),'47_2');

%%
% fprintf('\n%s\n','File... detections_041_96.mat');
% load('detections_041_95.mat')
% file1 = cs(end).filename;
% file1 = find(strcmp(cellstr(fileList),file1));
% load('detections_041_97.mat')
% file2 = cs(1).filename;
% file2 = find(strcmp(cellstr(fileList),file2));
% 
% files = file1+1:file2-1;
% 
% survey_data_fillin(buoyNo,diskNo,111,files(1:40),'96_1');
% survey_data_fillin(buoyNo,diskNo,111,files(41:50),'96_2');
% survey_data_fillin(buoyNo,diskNo,111,files(51:60),'96_3');
% survey_data_fillin(buoyNo,diskNo,111,files(61:70),'96_4');
% survey_data_fillin(buoyNo,diskNo,111,files(71:80),'96_5');
% 


%%
% fprintf('\n%s\n','File... detections_041_105.mat');
% load('detections_041_104.mat')
% file1 = cs(end).filename;
% file1 = find(strcmp(cellstr(fileList),file1));
% load('detections_041_106.mat')
% file2 = cs(1).filename;
% file2 = find(strcmp(cellstr(fileList),file2));
% 
% files = file1+1:file2-1;
% 
% survey_data_fillin(buoyNo,diskNo,111,files(1:floor(end/2)),'105_1');
% survey_data_fillin(buoyNo,diskNo,111,files(floor(end/2)+1:end),'105_2');

%%
% fprintf('\n%s\n','File... detections_041_107, 108, and 109.mat');
% load('detections_041_106.mat')
% file1 = cs(end).filename;
% file1 = find(strcmp(cellstr(fileList),file1));
% load('detections_041_110.mat')
% file2 = cs(1).filename;
% file2 = find(strcmp(cellstr(fileList),file2));
% 
% files = file1+1:file2-1;
% 
% survey_data_fillin(buoyNo,diskNo,111,files(1:2),'107_1');
% survey_data_fillin(buoyNo,diskNo,111,files(3),'107_2');
% 
% survey_data_fillin(buoyNo,diskNo,111,files(4:5),'108_1');
% survey_data_fillin(buoyNo,diskNo,111,files(6),'108_2');
% 
% survey_data_fillin(buoyNo,diskNo,111,files(7:8),'109_1');
% survey_data_fillin(buoyNo,diskNo,111,files(9),'109_2');



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
buoyNo='04';
diskNo='2';
% Get filelist for specified buoy and disk
fileList=dir(strcat('D:/Personal Folders/jlebien/DolphinData/Buoy',buoyNo));
fileList=extractfield(fileList,'name');
tmp=char(fileList);
fileList = fileList(tmp(:,end)==diskNo);

%%
fprintf('\n%s\n','File... detections_042_54.mat');
load('detections_042_53.mat')
file1 = cs(end).filename;
file1 = find(strcmp(cellstr(fileList),file1));
load('detections_042_55.mat')
file2 = cs(1).filename;
file2 = find(strcmp(cellstr(fileList),file2));

files = file1+1:file2-1;

survey_data_fillin(buoyNo,diskNo,111,files(1:9),'54_1');
survey_data_fillin(buoyNo,diskNo,111,files(10:19),'54_2');
survey_data_fillin(buoyNo,diskNo,111,files(20:26),'54_3');
survey_data_fillin(buoyNo,diskNo,111,files(27:29),'54_4');


%%
% fprintf('\n%s\n','File... detections_042_118.mat');
% load('detections_042_117.mat')
% file1 = cs(end).filename;
% file1 = find(strcmp(cellstr(fileList),file1));
% load('detections_042_119.mat')
% file2 = cs(1).filename;
% file2 = find(strcmp(cellstr(fileList),file2));
% 
% files = file1+1:file2-1;
% 
% survey_data_fillin(buoyNo,diskNo,111,files(1:9),'118_1');
% survey_data_fillin(buoyNo,diskNo,111,files(10:19),'118_2');
% survey_data_fillin(buoyNo,diskNo,111,files(20:26),'118_3');





