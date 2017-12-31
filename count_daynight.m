
cnts = zeros(24,1);

for ii = 0:23
    
    clear tmp
    tmp = dcounts(hour(dtbins)==ii);    
    cnts(ii+1,1)=mean(tmp);
    
end

% plot(cnts(:,1))
% hold on
% plot(cnts(:,2),'--')
% plot(cnts(:,3),'--')
% hold off
