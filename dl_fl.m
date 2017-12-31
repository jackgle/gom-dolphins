f = ftp('phys-ladc-store.louisiana.edu','ul-phys-user','uluser.ftp');
cd(f,'/Volumes/FirstRAID/Buoy04_DISK3/');
NotThere={};
k=1;

for ii = 1:length(fileList)
    curfile = fileList{ii};
    filePath = strcat('/Volumes/FirstRAID/Buoy',curfile(end-2:end-1),'_DISK',curfile(end),'/');
    
    if isempty(dir(filePath))
        NotThere{k}=curfile;
        k=k+1;
        continue;
    end
    
    %--- Check if directory changed, if so, then cd
    if length(filePath)~=length(cd(f)) || filePath~=cd(f)
        cd(f,filePath);
    end
    
    fprintf('\n%s %s','Downloading file...',curfile);
    
    mget(f,curfile,strcat('D:/Personal Folders/jlebien/DolphinData/Buoy',curfile(end-2:end-1),'/'));
end
NotThere=NotThere';
close(f)