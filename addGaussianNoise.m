% ECE 5523: Random Signals - Final Project
% Function to add Gaussian Noise
%
function noisySignal = addGaussianNoise(signal)
    meanNoise = 0;        % Mean of the noise
    varianceNoise = 0.01; % Variance of the noise

    noise = meanNoise + sqrt(varianceNoise) * randn(size(signal));
    noisySignal = signal + noise;
end