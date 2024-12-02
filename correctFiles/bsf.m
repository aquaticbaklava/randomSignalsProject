% ECE 5523: Random Signals - Final Project
% Function to apply adaptive bsf

function filteredSig = bsf(noisySig,snr)
    noisySig = noisySig / max(noisySig);
    bounds = [max(noisySig(:,1))/snr max(noisySig(:,1))-.00001];
    filteredSig = bandstop(noisySig,bounds);
end