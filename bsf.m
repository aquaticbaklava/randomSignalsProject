function filteredSig = bsf(noisySig,snr)
    bounds = [max(noisySig(:,1))/snr max(noisySig(:,1))];
    filteredSig = bandstop(noisySig,bounds);
end
