% ECE 5523: Random Signals - Final Project
% Function to add Gaussian Noise
%
function [noisySignal,ratio] = addGaussianNoise(signal, snr_ideal, fs)
    P_noise = snr_noise(snr_ideal,signal, 'G');

    meanNoise = 0;        % Mean of the noise
    varianceNoise = 0.01; % Variance of the noise

    noise = P_noise.*(meanNoise + sqrt(varianceNoise) .* randn(size(signal)));
    % FIGURE: gaussian noise
    figure;
    histogram(noise, 'normalization','pdf');
    title('Gaussian Noise');

    plotSpectrum(noise,fs,"Frequency Spectrum for Gaussian Noise")
    
    ratio = snr(signal(:,1),noise(:,1));
    noisySignal = signal + noise;
end

