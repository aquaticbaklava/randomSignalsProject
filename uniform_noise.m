%% Uniform noise removal
[signal, fs] = audioread('lucia_clean.wav'); % load in audio sample
signal = signal(:,1);

% FIGURE: original audio sample
figure;
plot(signal);
title('Original Audio Sample');
audio_sample = audioplayer(signal, fs);
playblocking(audio_sample);

%% Adding Noise
snr_ideal = 10; % in dB
P_noise = snr_noise(snr_ideal, signal, 'U');

U = P_noise*rand(length(signal),1); % generate uniform noise
snr_actual = snr(signal,U);
disp(snr_actual);

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
recovered_signal = lpf_averaging(noisy_signal);

figure;
plot(recovered_signal);
title('Linear Low-Pass Average Filter');
recovered_audio_sample = audioplayer(recovered_signal, fs);
playblocking(recovered_audio_sample);