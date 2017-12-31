function plot_cwt(signal,plotType,wv,vpo,numOct)

[wt, f] = cwt(signal,wv,192000,'VoicesPerOctave',vpo,'NumOctaves',numOct);

dt = 1/192000;
t=0:dt:(numel(signal)*dt)-dt;

clf;
helperCWTTimeFreqPlot(wt,t*1e6,f./1000,plotType','CWT of Echolocation',...
    'Microseconds','kHz')
% colormap( 1-gray.^3 ); %gamma-scaling
view(gca,0,90)
shg
