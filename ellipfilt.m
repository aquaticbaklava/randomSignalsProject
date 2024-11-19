% Function to apply ellip filter

function filteredSig = ellipfilt(noisySig, fs)
    % Filter param
    fc = 500; % Cutoff frequency in Hz
    rp = 1; % Passband ripple in dB
    rs = 40; % Stopband attenuation in dB
    n = 4; % Filter order

    % Design the Elliptic filter
    [b, a] = ellip(n, rp, rs, fc/(fs/2), 'low');

    % Apply the Elliptic filter
    filteredSig = filter(b, a, noisySig);
end


