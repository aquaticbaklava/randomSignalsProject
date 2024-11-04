function noisySignal = addRayleighNoise(signal)
    x = rand(length(signal),1); % make uniform first
    rayleigh = sqrt(-2.*log(x)); % get rayleigh from uniform
    noisySignal = signal + rayleigh;
end
