
clear
load('dol_counts.mat');

dcounts=[dcounts_0;dcounts_1;dcounts_2;dcounts_3];
dtbins=[dtbins_0,dtbins_1,dtbins_2,dtbins_3];

errors=[];
for ii = 2:length(dtbins)
if(dtbins(ii)~=dtbins(ii-1)+hours(1))
errors(ii) = 1;
end
end

dtbins(errors==1)=[];
dcounts(find(errors==1)-1)=dcounts(find(errors==1)-1)+dcounts(errors==1);
dcounts(errors==1)=[];

dtbins_tmp = dtbins(12:2819); % start and end of full days
dcounts_tmp = dcounts(12:2819);

day_counts=[];
dens=[];
k=1;

for ii = 1:24:length(dtbins_tmp)-23
    
    day_counts(k) = sum(dcounts_tmp(ii:ii+23));
    day_dates(k) = mean(dtbins_tmp(ii:ii+23));
    dens(k) = dol_dens(day_counts(k),.049,4,.014,.13,86400,13.5);
    k=k+1;
    
    
end


    