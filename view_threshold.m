%function view_threshold()
% plot threshold

[B,A] = butter(5, [(15000*2)/192000 (95000*2)/192000]);
% [B,A] = butter(5,(95000*2)/192000,'high');
signal = filtfilt(B,A,signal);
% Wavelet thresholding
signal = wden(signal,'minimaxi','s','sln',5,'sym8');

clf
plot(signal.^2);

thresh = (12*mad(signal))^2;

hold on
plot(ones(length(signal),1)*thresh);
axis tight
shg
hold off
