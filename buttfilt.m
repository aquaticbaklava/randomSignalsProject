function filteredSig = buttfilt(noisySig,snr)
    % normalize sig
    noisySig = noisySig/max(noisySig(:,1));
    wp = max(noisySig(:,1))/pi;
    ws = 0.45/pi/snr;
    rp = 1;
    rs = 30;
    [n,Wn]=buttord(wp,ws,rp,rs);
    [num,den] = butter(n,Wn,"low");
    
    filteredSig = filter(num,den,noisySig);
end
