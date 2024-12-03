% ECE 5523: Random Signals - Final Project
% Function to add Gaussian Noise
function [noisySignal,  ratio] = addGaussianNoise(signal, snr_ideal, as, fs)
   P_noise = snr_noise(snr_ideal, signal, 'G');
   meanNoise = 0;        % Mean of the noise
   varianceNoise = 1; % Variance of the noise
   noise = P_noise*(meanNoise + sqrt(varianceNoise) * randn(size(signal)));
   % FIGURE: gaussian noise
   figure;
   histfit(noise,20,'normal');
   title('Gaussian Noise');
   exportgraphics(gca,['G_hist_',num2str(snr_ideal),'_',num2str(as),'.png']);
   ratio = snr(signal,noise);
   noisySignal = signal + noise;

   plotSpectrum(noise,fs,"Frequency Spectrum for Gaussian Noise");
end

