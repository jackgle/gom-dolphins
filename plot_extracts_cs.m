function plot_extracts_cs(cstruct,buoyNo)

fileList = extractfield(cstruct,'filename');
fileList = unique(fileList);

clf;
shg;
xlabel('Time (s)');
hold on

for i = fileList
    filePath=strcat('D:/Personal Folders/jlebien/DolphinData/Buoy',buoyNo,'/',char(i));
    [~,signal] = readEARS(filePath);
    [datenumber, ~] = readEARStimestamp(filePath);
    dt=datetime(datenumber,'ConvertFrom','datenum');
    plot(dt:seconds(1/192000):dt+seconds(21.33333333),signal,'b');
    tmp = cstruct(logical(sum(char(cstruct.filename)==char(i),2)==12));
    for j = 1:length(tmp)
        scatter(dt+seconds((tmp(j).sample_pk-1)/192000),sqrt(max(tmp(j).sig.^2)),'r');
    end
end

axis tight
hold off

end

