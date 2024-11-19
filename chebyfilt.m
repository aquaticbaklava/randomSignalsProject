% Function to apply cheby1 filter

function filteredSig = chebyfilt(noisySig, fs)
    % Filter param
    fc = 500; % Cutoff frequency in Hz
    rp = 1; % Passband ripple in dB
    n = 4; % Filter order

    % Design the Chebyshev Type I filter
    [b, a] = cheby1(n, rp, fc/(fs/2), 'low');

    % Apply the Elliptic filter
    filteredSig = filter(b, a, noisySig);
end