function [isdol, array] = isdolphin2(click,Fs)

%% Analysis as in Frasier et al. 2015

click =     interp(click,5);
win =       hann(length(click))';
click =     click.*win;
Fs =        Fs*5;
nfft =      1024; % Length of FFT
[pxx,f] =   pwelch(click,[],[],nfft,Fs);
% fVals =     Fs*(0:(N_FFT/2)-1)/N_FFT;
% fbinsz =    fVals(2)-fVals(1);
fbinsz =    f(2)-f(1);
% cfft =      fft(click,N_FFT);
% cfft =      abs(cfft(1:N_FFT/2));


%% Pulse duration
%--- Caruso et al. 2016
% teager_click = teager(clickNoWin);
% thresh = 0.1*max(teager_click);
% pulseDur = range(find(teager_click>=thresh));
% pulseDur = pulseDur/Fs*1000; % duration in milliseconds

%--- Frasier et al. 2015
env = abs(hilbert(click)); 
env = (env-min(env))/(max(env)-min(env));
pulseDur = range(find(env>0.5));
pulseDur = pulseDur/Fs*1000; % duration in milliseconds


%% Symmetry ratio
%--- Frasier et al. 2015
start=min(find(env>0.5));
endd = max(find(env>0.5));
tmp = env(start:endd);
symRatio = sum(tmp(1:floor(end/2)))/sum(tmp(floor(end/2)+1:end));

%% Number of zero crossings
% tmp = abs(hilbert(click)); % get click envelope
% mx=max(tmp);
% mx_dB = 20*log10(mx);
% thresh = 10^((mx_dB-10)/20); % set the threshold at -10 dB from maximum of envelope
% zci = @(v) find(v(:).*circshift(v(:), [-1 0]) <= 0); % function for computing number of zero crossings
% tmp = find(tmp>=thresh);
% zero_xs = length(zci(click(min(tmp):max(tmp))));

%% Spectral centroid
% tmp = cumsum(cfft/sum(cfft)); % frequency that divides spectrum into equal halves of energy
% [~,index] = min(abs(tmp-0.5));
% fc = fVals(index)+fbinsz/2;
% fc = (sum((fVals+fbinsz/2).*cfft)/sum(cfft));

%% RMS bandwidth
% bw_rms = sqrt(sum((fVals.^2).*(cfft.^2))/sum(cfft.^2));
% bw_rms = sqrt(4*sum((((fVals+fbinsz/2)-fc).^2).*(cfft.^2))/sum(cfft.^2));

%% Q_rms
% Qrms = fc/bw_rms;

%% Number of peak frequencies
% [pxx,f] = pwelch(click,[],[],[],Fs);
% [pxx,f] = periodogram(click,[],[],Fs);
% tmp = pxx(10*log10(pxx)>max(10*log10(pxx))-10);
% if length(tmp) < 3
%     Nofp = 1;
% else
%     Nofp = length(findpeaks(tmp));
% end

%% Peak frequency
fp = f(pxx==max(pxx))+fbinsz/2;

%% Classification

if pulseDur > 0.01   &&...
   pulseDur < 0.07   &&...
   fp       > 20000  &&...
   fp       < 80000  &&...
   symRatio > 1

    isdol=1;
else
    isdol=0;
end


array = [pulseDur, fp, symRatio];
end
   
    


