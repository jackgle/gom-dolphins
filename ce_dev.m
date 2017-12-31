function [cs] = ce_dev(signal,time,frame_size,filename)

if iscolumn(signal)
    signal=signal';
end

% Ensure the frame size is odd so that the click can be centered
if (mod(frame_size,2)==0)
    frame_size = frame_size+1;
end

% % Apply 10-pole Butterworth bandpass filter (15-85 kHz) before detection
[B,A] = butter(6, [(15000*2)/192000 (85000*2)/192000]);
signal = filtfilt(B,A,signal);
% % Wavelet thresholding
% signal = wden(signal,'minimaxi','s','sln',5,'sym8');

thresh = 4e-6; % Set constant amplitude threshold

[~, locs] = findpeaks(signal.^2,'MinPeakDistance',(frame_size-1)/2,'MinPeakHeight',thresh); % Find peaks
if isempty(locs)
    cs=[];
    return
end

%% Optionally plot signal and highlight detected peaks
% clf
% tmp=signal.^2;
% plot(tmp)
% hold on
% scatter(locs,tmp(locs),'r');
% shg

%% Populate the data structure
cs = struct();
for i = 1:size(locs,2)
    
    if locs(i)+((frame_size/2)-0.5) > size(signal,2)
        cs(i).sig = signal(locs(i)-((frame_size/2)-0.5):end);
        cs(i).sample_pk = locs(i);
        cs(i).time_pk = time(locs(i));
        cs(i).time = time(locs(i)-((frame_size/2)-0.5):end);
        cs(i).sample = locs(i)-((frame_size/2)-0.5):size(signal,2);
    elseif locs(i)-((frame_size/2)-0.5) < 1
        cs(i).sig = signal(1:locs(i)+((frame_size/2)-0.5));
        cs(i).sample_pk = locs(i);
        cs(i).time_pk = time(locs(i));
        cs(i).time = time(1:locs(i)+((frame_size/2)-0.5));
        cs(i).sample = 1:locs(i)+((frame_size/2)-0.5);
    else
        cs(i).sig = signal(locs(i)-((frame_size/2)-0.5):locs(i)+((frame_size/2)-0.5));
        cs(i).sample_pk = locs(i);
        cs(i).time_pk = time(locs(i));
        cs(i).time = time(locs(i)-((frame_size/2)-0.5):locs(i)+((frame_size/2)-0.5))';
        cs(i).sample = locs(i)-((frame_size/2)-0.5):locs(i)+((frame_size/2)-0.5);
    end
    cs(i).filename = filename;
    cs(i).noise = signal(.003*192000:round(.013*192000)); % First 3-13 ms of file collected as noise estimate
end

%len = length(cs);
%fprintf('Number of frames extracted: %i\n\n',len);
