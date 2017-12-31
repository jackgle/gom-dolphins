%% Get list of downloaded files (query)
dllist=dir('D:/Personal Folders/jlebien/DolphinData/Buoy04');
dllist=extractfield(dllist,'name');

%% Remove DISKS 1 and 2 for Buoy01 subject files
% j=1;
% for i = 1:length(fileList)
%     if fileList{i}(end) == '1' || fileList{i}(end) == '2'
%         continue
%     end
%     tmp{j}=fileList{i};
%     j=j+1;
% end
% fileList=tmp;
% clear tmp

%% If missing_files is empty, download was succesfully completed
missing_files=setdiff(fileList,dllist)

