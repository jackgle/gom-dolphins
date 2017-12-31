function [isdol, array] = isdolphin_caruso(click,Fs)

%% Analysis based on Caruso et al. 2016

rawclick=click;
click =     interp(click,5);
win =       hann(length(click))';
click =     click.*win;
Fs =        Fs*5;
N_FFT =     1024; % Length of FFT
% [pxx,f] =   pwelch(click,[],[],nfft,Fs);
fVals =     Fs*(0:(N_FFT/2)-1)/N_FFT;
fbinsz =    fVals(2)-fVals(1);
% fbinsz =    f(2)-f(1);
cfft =      fft(click,N_FFT);
cfft =      abs(cfft(1:N_FFT/2));


%% Pulse duration
teager_click = teager(click);
thresh = 0.1*max(teager_click);
pulseDur = range(find(teager_click>=thresh));
pulseDur = pulseDur/Fs*1000; % duration in milliseconds

%% Number of zero crossings
tmp = abs(hilbert(click)); % get click envelope
mx=max(tmp);
mx_dB = 20*log10(mx);
thresh = 10^((mx_dB-10)/20); % set the threshold at -10 dB from maximum of envelope
zci = @(v) find(v(:).*circshift(v(:), [-1 0]) <= 0); % function for computing number of zero crossings
tmp = find(tmp>=thresh);
zero_xs = length(zci(click(min(tmp):max(tmp))));

%% Spectral centroid
% tmp = cumsum(pxx/sum(pxx));
% [~,index] = min(abs(tmp-0.5));
% fc = f(index)+((f(2)-f(1))/2);

tmp = cumsum(cfft/sum(cfft)); % frequency that divides spectrum into equal halves of energy
[~,index] = min(abs(tmp-0.5));
fc = fVals(index)+fbinsz/2;

% fc = (sum((fVals+fbinsz/2).*cfft)/sum(cfft));

%% RMS bandwidth
% bw_rms = sqrt(sum((fVals.^2).*(cfft.^2))/sum(cfft.^2));
bw_rms = sqrt(4*sum((((fVals+fbinsz/2)-fc).^2).*(cfft.^2))/sum(cfft.^2));
% bw_rms = sqrt(4*sum((((f+fbinsz/2)-fc).^2).*(pxx.^2))/sum(pxx.^2));


%% Q_rms
Qrms = fc/bw_rms;

%% Number of peak frequencies
[pxx,f] = pwelch(click,[],[],[],Fs);
% [pxx,f] = periodogram(click,[],[],Fs);
tmp = pxx(10*log10(pxx)>max(10*log10(pxx))-10);
if length(tmp) < 3
    Nofp = 1;
else
    Nofp = length(findpeaks(tmp));
end

%% Peak frequency
fp = f(pxx==max(pxx));

%% Classification

if pulseDur < 0.2   &&... % edited from caruso's 0.4 criterion
   Nofp     < 4     &&...
   Qrms     > 1     &&...
   zero_xs  < 20    &&...
   zero_xs  > 1     &&... % edited from caruso's 2 criterion
   fp+fc    > 30000 &&...
   fc       > 20000 &&... % added to caruso criteria
   sum(abs(rawclick(1:10)))>7e-5 % to filter out pops at beginning of file
   %    fc       < 90000
   
    isdol=1;
else
    isdol=0;
end


array = [pulseDur, zero_xs, fc, bw_rms, Qrms, Nofp, fp];
end
   
    


