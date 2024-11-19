function filteredSig = lpf(noisySig,snr)
    % use snr to adapt threshold
    filteredSig = lowpass(noisySig,max(noisySig(:,1))/snr);
end
