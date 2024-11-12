function [noisySignal, ratio] = addExponentialNoise(signal, SNR)
    x = rand(length(signal),1);
    pnoise = snr_noise(SNR,signal,'E');
    exponential = -1*log(1-x).*pnoise(1);
    noisySignal = signal + exponential;
    ratio = snr(signal(:,1),exponential);
end
