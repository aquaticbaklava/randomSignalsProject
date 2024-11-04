%% Uniform noise removal
[signal, fs] = audioread('lucia_clean.wav'); % load in audio sample

% FIGURE: original audio sample
figure;
plot(signal(:,1));
title('Original Audio Sample');
audio_sample = audioplayer(signal(:,1), fs);
playblocking(audio_sample);

%% Adding Noise
U = max(abs(signal), [], 'all')*(rand(length(signal),1) - 0.5); % generate uniform noise

% FIGURE: uniform noise
figure;
plot(U);
title('Uniform Noise');

noisy_signal = signal(:,1) + U; % add noise to audio sample

% FIGURE: noisy audio sample
figure;
plot(noisy_signal(:,1));
title('Uniform Noise Audio Sample');
noisy_audio_sample = audioplayer(noisy_signal, fs);
playblocking(noisy_audio_sample);

%% Removing Noise
signal_lpf = bandpass(noisy_signal,[10, 500],fs);

figure;
plot(signal(:,1));
hold on
plot(signal_lpf);
title('Original vs LPF')

playblocking(audioplayer(signal_lpf,fs));

% signal_removed = remove_uniform_noise(noisy_signal, fs); % remove noise from audio sample
% 
% function signal_clean = remove_uniform_noise(signal, fs)
% % signal: noisy signal with uniform noise
% % fs: sampling frequency of audio sample
% 
% 
% 
% 
% end