function filteredSig = buttfilt(noisySig,cleanSig)
    wp = max(cleanSig(:,1))/pi;
    ws = 0.2/pi;
    rp =1;
    rs = 30;
    [n,Wn]=buttord(wp,ws,rp,rs);
    [num,den] = butter(n,Wn,"low");
    
    filteredSig = filter(num,den,noisySig);
end
