% ECE 5523: Random Signals - Final Project
% Function to add Rayleigh Noise

function [noisySignal, ratio] = addRayleighNoise(signal, SNR, as)
    x = rand(length(signal),1); % make uniform first
    pnoise = snr_noise(SNR,signal,'R');
    rayleigh = sqrt(-2.*log(x)).*pnoise(1); % get rayleigh from uniform
    % get SNR and multiply to get what we want

    %FIGURE: rayleigh noise
    figure;
    histfit(rayleigh,20,'rayleigh');
    title('Rayleigh Noise');
    exportgraphics(gca,['R_hist_',num2str(SNR),'_',num2str(as),'.png']);


    ratio = snr(signal(:,1),rayleigh);
    noisySignal = signal + rayleigh;
end