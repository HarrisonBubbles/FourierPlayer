% read audio file
directory = pwd;
audio = input('Which file?');
path = append('Sounds\', audio);
info = audioinfo(fullfile(directory, path));
[y,Fs] = audioread(fullfile(directory, path));

% get total samples from file and round to the next
% highest power of 2 (for better frequency resolution)
L = 2^nextpow2(info.TotalSamples);

Ts = 1/Fs; % sampling period
dt = 0:Ts:info.Duration - Ts; % signal duration vector

% compute Fourier transform of signal
ff = fft(y, L); 
fff = ff(1:L/2);

freq = Fs*(0:(L/2)-1)/L; % calculate frequency
amp = abs(fff); % get amplitude (real part of transform)
namp = amp/max(amp); % normalize amplitude

% plot original signal
subplot(2,1, 1);
plot(dt,y);
xlabel('Time (sec)');
ylabel('Amplitude');
title('Original Signal');

% plot transformed signal
subplot(2,1, 2);
plot(freq, namp);
xlim([0, 1000]);
xlabel('Frequency (Hz)');
ylabel('Amplitude');
title('Transformed Signal');

thresh = 0.5; % threshold 
% error margin 

% filter data for frequency peaks
% (aka the "notes" we're looking for)
init_peaks = findpeaks(namp);
filter = init_peaks > thresh;
peaks = init_peaks(filter);

% make a list of identified pitches from signal
lop = [];
for i = 1:length(peaks)
    index = find(namp == peaks(i));
    pitch = freq(index);
    lop = [lop, pitch];
end
lop

