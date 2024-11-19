function filteredSig = bsf(noisySig,snr)
    % normalize sig
    noisySig = noisySig/max(noisySig(:,1));
    bounds = [max(noisySig(:,1))/snr max(noisySig(:,1))-.00001];
    filteredSig = bandstop(noisySig,bounds);
end
