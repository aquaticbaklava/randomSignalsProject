function [noisySignal, ratio] = addExponentialNoise(signal)
    x = rand(length(signal),1);
    pnoise = snr_noise(15,signal,'E');
    exponential = -1*log(1-x).*pnoise(1);
    noisySignal = signal + exponential;
    ratio = snr(signal(:,1),exponential);
end
