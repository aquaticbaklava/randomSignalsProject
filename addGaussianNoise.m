% ECE 5523: Random Signals - Final Project
% Function to add Gaussian Noise

function noisySignal = addGaussianNoise(signal, snr_ideal)
    P_noise = snr_noise(snr_ideal,signal, 'G');

    meanNoise = 0;        % Mean of the noise
    varianceNoise = 0.01; % Variance of the noise

    noise = P_noise*(meanNoise + sqrt(varianceNoise) * randn(size(signal)));

    % FIGURE: gaussian noise
    figure;
    plot(noise);
    title('Gaussian Noise');

    noisySignal = signal + noise;
end