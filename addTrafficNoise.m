% ECE 5523: Random Signals - Final Project
% Function to add Traffic Noise
%

function [noisySignal,ratio] = addTrafficNoise(signal, fs_s)
    [trafficNoise, fs_tn] = audioread('sound_traffic.wav');

    % If the sampling frequencies are different,
    % resample trafficNoise to match cleanWoman
    if fs_s ~= fs_tn
        trafficNoise = resample(trafficNoise, fs_s, fs_tn);
        fs_tn = fs_s;
    end

    % Get the lengths of the signals
    len_s = length(signal);
    len_tn = length(trafficNoise);

    plotSpectrum(trafficNoise,fs_s,"Frequency Spectrum for Traffic Noise")

    % Select a segment from trafficNoise with the same length as signal
    start_index = randi([1, len_tn - len_s + 1]);
    trafficNoise_added = trafficNoise(start_index:start_index + len_s - 1, :);
    ratio = snr(signal(:,1),trafficNoise_added(:,1));
    % Add the noise segment to cleanWoman
    noisySignal = signal + trafficNoise_added;

    % Normalize the noisy signal if needed (optional)
    noisySignal = noisySignal / max(abs(noisySignal(:)));
end