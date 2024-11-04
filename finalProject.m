% ECE 5523: Random Signals - Final Project
% Team Members: Breanna Mapes, Lucia Torres, Ayano Ueki
%
% Description:
% On Digital Filtering for Noise Reduction in Audio Samples

% Step 1: Load the original WAV files
[cleanWoman, fs_cw] = audioread('lucia_clean.wav');
[cleanMan, fs_cm] = audioread('cody_clean.wav');

% Step 2: Play the original WAV file
playSignal(cleanWoman, fs_cw, 'cleanWoman')

% Step 3: Add Gaussian noise to the cleanWoman signal
gaussianSignal = addGaussianNoise(cleanWoman);

% Step 4: Play the noise-added WAV file
playSignal(gaussianSignal, fs_cw, 'gaussianWoman');

% Step 5: Save the noise-added audio to a new file
audiowrite('gaussianWoman.wav', gaussianSignal, fs_cw); % Saves as 'gaussianWoman.wav'
disp('Noise-added WAV file saved as "gaussianWoman.wav".');
