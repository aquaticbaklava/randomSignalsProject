function [noisySignal,ratio] = addRayleighNoise(signal, SNR)
    x = rand(length(signal),1); % make uniform first
    pnoise = snr_noise(SNR,signal,'R');
    rayleigh = sqrt(-2.*log(x)).*pnoise(1); % get rayleigh from uniform
    % get SNR and multiply to get what we want
    ratio = snr(signal(:,1),rayleigh);
    noisySignal = signal + rayleigh;
end
