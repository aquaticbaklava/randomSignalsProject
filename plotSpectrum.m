function plotSpectrum(cleanSignal, fs, titleWords)
    N = length(cleanSignal);
    [freqSignal, freq] = easyFFT(cleanSignal,N,1,fs);
    freqSignal = abs(freqSignal);
    figure;
    plot(freq,freqSignal(:,1));
    xlabel("Frequency (Hz)");
    ylabel("Power Spectrum Density");
    title(titleWords);
    xlim([-1500 1500]);
end
