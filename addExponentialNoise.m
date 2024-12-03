% ECE 5523: Random Signals - Final Project
% Function to add Exponential Noise
function [noisySignal, ratio] = addExponentialNoise(signal, SNR, as, fs)
   x = rand(length(signal),1);
   pnoise = snr_noise(SNR,signal,'E');
   exponential = -1*log(1-x).*pnoise(1);
  
   % FIGURE: exponential noise
   figure;
   histfit(exponential,20,'exponential');
   title('Exponential Noise');
   exportgraphics(gca,['E_hist_',num2str(SNR),'_',num2str(as),'.png']);
   noisySignal = signal + exponential;
   ratio = snr(signal(:,1),exponential);

   plotSpectrum(exponential,fs, "Frequency Spectrum for Exponential Noise");
end
