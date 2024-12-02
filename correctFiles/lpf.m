% ECE 5523: Random Signals - Final Project
% Function to apply lpf

function filteredSig = lpf(noisySig,snr)
    % noisySig = noisySig / max(noisySig);
    % use snr to adapt threshold
    snr = 10^(snr/10);
    filteredSig = lowpass(noisySig,max(noisySig(:,1))/snr);
end