% ECE 5523: Random Signals - Final Project
% Team Members: Breanna Mapes, Lucia Torres, Ayano Ueki
%
% Description:
% On Digital Filtering for Noise Reduction in Audio Samples

% Step 1: Load the original WAV files without noise
[cleanWoman, fs_cw] = audioread('lucia_clean.wav');
[cleanMan, fs_cm] = audioread('cody_clean.wav');
[trafficNoise, fs_tn] = audioread('sound_traffic.wav');

% Step 2: Play the original WAV file without noise
playSignal(cleanWoman, fs_cw, 'cleanWoman')

% Step 3: Add Gaussian noise to the cleanWoman signal
gaussianSignal = addGaussianNoise(cleanWoman);

% Step 4: Play the noise-added WAV file
playSignal(gaussianSignal, fs_cw, 'gaussianWoman');

% Step 5: Save the noise-added audio to a new file
audiowrite('gaussianWoman.wav', gaussianSignal, fs_cw);
disp('Noise-added WAV file saved as "gaussianWoman.wav".');

% repeat steps 3-5 for Rayleigh noises
%% Rayleigh
% step 3: Add Rayleigh noise to signals
rayleighWoman = addRayleighNoise(cleanWoman);
rayleighMan = addRayleighNoise(cleanMan);

% step 4: Play the noise-added WAV file
playSignal(rayleighWoman, fs_cw, 'rayleighWoman');
playSignal(rayleighMan, fs_cm, 'rayleighMan');

% step 5: Save the noise-added audios to new files
audiowrite('rayleighWoman.wav',rayleighWoman,fs_cw);
disp('Noise-added WAV file saved as "rayleighWoman.wav".');

audiowrite('rayleighMan.wav',rayleighMan,fs_cm);
disp('Noise-added WAV file saved as "rayleighWoman.wav".');

%% plot comparisons
figure(300);
subplot(2,1,1);
plot(cleanWoman);
title("Clean audio sample (woman)");
subplot(2,1,2);
plot(rayleighWoman);
title("Noisy audio sample (woman)");

figure(301);
subplot(2,1,1);
plot(cleanMan);
title("Clean audio sample (man)");
subplot(2,1,2);
plot(rayleighMan);
title("Noisy audio sample (man)");

% repeat steps 3-5 for traffic noises
trafficWoman = addTrafficNoise(cleanWoman, fs_cw);

% step 4: Play the noise-added WAV file
playSignal(trafficWoman, fs_cw, 'trafficWoman');

% step 5: Save the noise-added audios to new files
audiowrite('trafficWoman.wav',trafficWoman,fs_cw);
disp('Noise-added WAV file saved as "trafficWoman.wav".');
