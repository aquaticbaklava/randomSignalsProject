% ECE 5523: Random Signals - Final Project
% Function to apply linear lowpass averaging filter

function rec_sig = lpf_averaging(signal)
% LPF_AVERAGING: applies linear low pass averaging filter to signal
% signal: noisy signal

pad = 3;
samps = length(signal);
samps_pad = padarray(signal,pad); % zero pad for special cases

rec_sig = zeros(size(samps_pad)); % size of zero padded image
for s = (1:samps)+pad % actual image
    % linear average filter at every sample
    rec_sig(s) = sum(sum(samps_pad(s-pad:s+pad)))/7; 
end
rec_sig = rec_sig(1+pad:end-pad);

end

