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
xlim([0, 5000]);
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

% all pitch names
names = {'C0';
    'C1';
    'C2';
    'C3';
    'C4';
    'C5';
    'C6';
    'C7';
    'C8';
    'C#0/D-0';
    'C#1/D-1';
    'C#2/D-2';
    'C#3/D-3';
    'C#4/D-4';
    'C#5/D-5';
    'C#6/D-6';
    'C#7/D-7';
    'C#8/D-8';
    'D0';
    'D1';
    'D2';
    'D3';
    'D4';
    'D5';
    'D6';
    'D7';
    'D8';
    'D+0/E-0';
    'D1+/E-1';
    'D2+/E-2';
    'D3+/E-3';
    'D4+/E-4';
    'D5+/E-5';
    'D6+/E-6';
    'D7+/E-7';
    'D8+/E-8';
    'E0';
    'E1';
    'E2';
    'E3';
    'E4';
    'E5';
    'E6';
    'E7';
    'E8';
    'F0';
    'F1';
    'F2';
    'F3';
    'F4';
    'F5';
    'F6';
    'F7';
    'F8';
    'F+0/G-0';
    'F+1/G-1';
    'F+2/G-2';
    'F+3/G-3';
    'F+4/G-4';
    'F+5/G-5';
    'F+6/G-6';
    'F+7/G-7';
    'F+8/G-8';
    'G0';
    'G1';
    'G2';
    'G3';
    'G4';
    'G5';
    'G6';
    'G7';
    'G8';
    'G+0/A-0';
    'G+1/A-1';
    'G+2/A-2';
    'G+3/A-3';
    'G+4/A-4';
    'G+5/A-5';
    'G+6/A-6';
    'G+7/A-7';
    'G+8/A-8';
    'A0';
    'A1';
    'A2';
    'A3';
    'A4';
    'A5';
    'A6';
    'A7';
    'A8';
    'A+0/B-0';
    'A+1/B-1';
    'A+2/B-2';
    'A+3/B-3';
    'A+4/B-4';
    'A+5/B-5';
    'A+6/B-6';
    'A+7/B-7';
    'A+8/B-8';
    'B0';
    'B1';
    'B2';
    'B3';
    'B4';
    'B5';
    'B6';
    'B7';
    'B8'}

% create array of frequencies associated with above notes
pitches = zeros(108, 1);
for i = 1:108
    pitches(i) = 440 * (2^(1/12))^(i-58);
end
pitches(58)
