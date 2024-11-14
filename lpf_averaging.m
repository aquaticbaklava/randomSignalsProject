function rec_sig = lpf_averaging(signal)
% LPF_AVERAGING: applies linear low pass averaging filter to signal
% signal: noisy signal

samps = length(signal);
samps_pad = padarray(signal,3); % zero pad for special cases

rec_sig = zeros(size(samps_pad)); % size of zero padded image
for s = (1:samps)+3 % actual image
    % linear average filter at every sample
    rec_sig(s) = sum(sum(samps_pad(s-3:s+3)))/7; 
end
rec_sig = rec_sig(1+3:end-3);

figure;
plot(rec_sig);
title('Linear Low-Pass Average Filter');
recovered_audio_sample = audioplayer(rec_sig, fs);
playblocking(recovered_audio_sample);

end

