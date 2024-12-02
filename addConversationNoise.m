% ECE 5523: Random Signals - Final Project
% Function to add Traffic Noise
%

function noisySignal = addConversationNoise(signal, fs_s)
    [conversationNoise, fs_tn] = audioread('sound_conversation2.wav');

    % If the sampling frequencies are different,
    % resample trafficNoise to match cleanWoman
    if fs_s ~= fs_tn
        conversationNoise = resample(conversationNoise, fs_s, fs_tn);
        fs_tn = fs_s;
    end

    % Get the lengths of the signals
    len_s = length(signal);
    len_tn = length(conversationNoise);

    % Select a segment from trafficNoise with the same length as signal
    start_index = randi([1, len_tn - len_s + 1]);
    conversationNoise_added = conversationNoise(start_index:start_index + len_s - 1, :);

    plotSpectrum(conversationNoise,fs_s,"Frequency Spectrum for Conversation Noise")

    % Add the noise segment to cleanWoman
    noisySignal = signal + conversationNoise_added;

    % Normalize the noisy signal if needed (optional)
    noisySignal = noisySignal / max(abs(noisySignal(:)));
end