% ECE 5523: Random Signals - Final Project
% Function to add Conversation Noise
function [noisySignal, ratio] = addConversationNoise(signal, fs_s, as)
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
   if as == 1
       conversationNoise_added = .68*conversationNoise(start_index:start_index + len_s - 1, 1);
   else
       conversationNoise_added = .47*conversationNoise(start_index:start_index + len_s - 1, 1);
   end
   % FIGURE: conversation noise
   figure;
   plot(conversationNoise_added);
   title('Background Conversation Noise');
   exportgraphics(gca,['C_hist_',num2str(as),'.png']);

   plotSpectrum(conversationNoise,fs_s,"Frequency Spectrum for Conversation Noise");

  
   ratio = snr(signal,conversationNoise_added);
   % Add the noise segment to cleanWoman
   noisySignal = signal + conversationNoise_added;
   % Normalize the noisy signal if needed (optional)
   noisySignal = noisySignal / max(abs(noisySignal(:)));
end
