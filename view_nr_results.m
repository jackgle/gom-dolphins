subplot(2,1,1)
ax1=gca;
plot(signal);
title('Raw Signal');
subplot(2,1,2)
ax2=gca;
plot(signalp);
title('Bandpass Filter -> Wavelet Thresholding');
linkaxes([ax1,ax2],'xy');
axis tight