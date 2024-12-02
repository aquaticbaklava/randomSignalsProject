% ECE 5523: Random Signals - Final Project
% Function to add Traffic Noise

function [noisySignal, ratio] = addTrafficNoise(signal, fs_s, as)
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

    % Select a segment from trafficNoise with the same length as signal
    start_index = randi([1, len_tn - len_s + 1]);
    % to make sure SNR is between 5 and 15 dB
    if as == 1
        trafficNoise_added = 1.2*trafficNoise(start_index:start_index + len_s - 1, 1);
    else
        trafficNoise_added = 0.9*trafficNoise(start_index:start_index + len_s - 1, 1);
    end

    % FIGURE: traffic noise
    figure;
    plot(trafficNoise_added);
    title('Traffic Noise');
    exportgraphics(gca,['T_hist_',num2str(as),'.png']);

    ratio = snr(signal, trafficNoise_added);
    % Add the noise segment to cleanWoman
    noisySignal = signal + trafficNoise_added;

    % Normalize the noisy signal if needed (optional)
    noisySignal = noisySignal / max(abs(noisySignal(:)));
end