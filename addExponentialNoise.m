function [noisySignal, ratio] = addExponentialNoise(signal, SNR, fs)
    x = rand(length(signal),1);
    pnoise = snr_noise(SNR,signal,'E');
    exponential = -1*log(1-x).*pnoise(1);
    figure;
    histfit(exponential,20,'exponential');
    plotSpectrum(exponential,fs, "Frequency Spectrum for Exponential Noise");
    noisySignal = signal + exponential;
    ratio = snr(signal(:,1),exponential);
end