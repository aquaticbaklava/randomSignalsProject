% ECE 5523: Random Signals - Final Project
% Function to apply butterworth filter

function filteredSig = buttfilt(noisySig,snr)
    noisySig = noisySig / max(noisySig);
    wp = max(noisySig(:,1))/pi;
    % use snr to get adaptive ws
    snr = 10^(snr/10);
    ws = 0.45/pi/snr;
    rp =1;
    rs = 30;
    [n,Wn]=buttord(wp,ws,rp,rs);
    [num,den] = butter(n,Wn,"low");
    
    filteredSig = filter(num,den,noisySig);
end