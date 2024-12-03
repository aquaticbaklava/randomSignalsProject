% ECE 5523: Random Signals - Final Project
% Function to add Gaussian Noise
function [noisy_signal, ratio] = addUniformNoise(signal, snr_ideal, as, fs)
   P_noise = snr_noise(snr_ideal, signal, 'U');
  
   U = P_noise*rand(length(signal),1); % generate uniform noise
  
   % FIGURE: uniform noise
   hist_U = histogram(U);
   figure;
   histogram(U);
   avgHeight = numel(U)/hist_U.NumBins;
   hold on;
   plot([min(U), max(U)],[avgHeight, avgHeight], 'LineWidth',2, 'Color', 'r')
   title('Uniform Noise');
   exportgraphics(gca,['U_hist_',num2str(snr_ideal),'_',num2str(as),'.png']);
  
   ratio = snr(signal, U);
   noisy_signal = signal + U; % add noise to audio sample
   
   plotSpectrum(U,fs,"Frequency Spectrum for Uniform Noise");

end
