% ECE 5523: Random Signals - Final Project
% Function to add Gaussian Noise

function noisy_signal = addUniformNoise(signal, snr_ideal)
    P_noise = snr_noise(snr_ideal, signal, 'U');
    
    U = P_noise*rand(length(signal),1); % generate uniform noise
    
    % FIGURE: uniform noise
    figure;
    plot(U);
    title('Uniform Noise');
    
    noisy_signal = signal + U; % add noise to audio sample
end

