%% Final Project Script
% Lucia Torres, Breanna Mapes, Ayano Ueki
%% Load in Clean Samples
% Lucia audio sample
[signal_l, fs] = audioread('lucia_clean.wav'); % load in audio sample
signal_l = signal_l(:,1); % one dimensional array
signal_l = signal_l / max(signal_l);
time_l = 0:1/fs:length(signal_l)*1/fs - 1/fs;

% FIGURE: original audio sample
figure;
plot(time_l, signal_l);
xlabel('Time (s)');
ylabel('Amplitude');
title('Original Audio Sample - Woman');
exportgraphics(gca,'lucia_clean.png');
playSignal(signal_l, fs, 'Woman');

%FIGURE: original audio sample frequency spectrum
plotSpectrum(signal_l, fs,"Frequency Spectrum for Woman's Voice");

% Cody audio sample
[signal_c, fs] = audioread('cody_clean.wav'); % load in audio sample
signal_c = signal_c(:,1); % one dimensional array
signal_c = signal_c / max(signal_c);
time_c = 0:1/fs:length(signal_c)*1/fs - 1/fs;

% FIGURE: original audio sample
figure;
plot(time_c, signal_c);
xlabel('Time (s)');
ylabel('Amplitude');
title('Original Audio Sample - Man');
exportgraphics(gca,'cody_clean.png');
playSignal(signal_c, fs, 'Man');

%FIGURE: original audio sample frequency spectrum
plotSpectrum(signal_c, fs,"Frequency Spectrum for Man's Voice");

% prealocating data
snr_actual_g = zeros(2,3); % rows: audio file col: SNR
err_g = zeros(2,3,5); % x: audio files y: SNR z: rmse
snr_actual_u = zeros(2,3);
err_u = zeros(2,3,5); % x: audio files, y: SNRs, z: filters
snr_actual_e = zeros(2,3);
err_e = zeros(2,3,5); % x: audio files, y: SNRs, z: filters
snr_actual_r = zeros(2,3);
err_r = zeros(2,3,5); % x: audio files, y: SNRs, z: filters
snr_actual_t = zeros(2,1); % 2 audio files, one snr
err_t = zeros(2,1,5); % x: audio files, y: SNRs, z: filters
snr_actual_c = zeros(2,1); % 2 audio files, one snr
err_c = zeros(2,1,5); % x: audio files, y: SNRs, z: filters

for as = 1:2
   % determine audio sample
   if as == 1
       signal = signal_l;
       time = time_l;
   else
       signal = signal_c;
       time = time_c;
   end
   %% Gaussian Noise
   for s = 1:3
       snr_ideal = s*5;
       [noisy_signal, snr_actual_g(as,s)] = addGaussianNoise(signal, snr_ideal, as, fs);
     
       % FIGURE: noisy audio sample
       figure;
       plot(time,noisy_signal);
       title(['Gaussian Noise Audio Sample (',num2str(snr_ideal),' dB SNR)']);
       xlabel('Time (s)');
       ylabel('Amplitude');
       exportgraphics(gca,['G_noise_',num2str(snr_ideal),'_',num2str(as),'.png']);
       playSignal(noisy_signal, fs, 'Gaussian');
       audiowrite(['gaussian_noise_',num2str(snr_ideal),'_',num2str(as),'.wav'],noisy_signal,fs);
      
       % Removing Noise
       % lowpass filter
       lpf_recovery = lpf(noisy_signal, snr_actual_g(as,s));
       err_g(as,s,1) = rmse(signal, lpf_recovery);
  
       figure;
       plot(time,lpf_recovery);
       title(['Lowpass Filter on Gaussian (', num2str(snr_ideal), ' dB SNR)']);
       xlabel('Time (s)');
       ylabel('Amplitude');
       exportgraphics(gca,['G_lpf_',num2str(snr_ideal),'_',num2str(as),'.png']);

       plotSpectrum(lpf_recovery,fs,sprintf("Lowpass Filter on Gaussian (%d dB) \n Frequency Spectrum", snr_ideal));
      
       playSignal(lpf_recovery, fs, 'LPF G');
       audiowrite(['gaussian_lpf_',num2str(snr_ideal),'_',num2str(as),'.wav'],lpf_recovery,fs);
      
       % bandstop filter
       bsf_recovery = bsf(noisy_signal,snr_actual_g(as,s));
       err_g(as,s,2) = rmse(signal, bsf_recovery);
       figure;
       plot(time,bsf_recovery);
       title(['Bandstop Filter on Gaussian (',num2str(snr_ideal),' dB SNR)']);
       xlabel('Time (s)');
       ylabel('Amplitude');
       exportgraphics(gca,['G_bsf_',num2str(snr_ideal),'_',num2str(as),'.png']);
       playSignal(bsf_recovery, fs, 'BSF G');
       audiowrite(['gaussian_bsf_',num2str(snr_ideal),'_',num2str(as),'.wav'],bsf_recovery,fs);

       plotSpectrum(bsf_recovery,fs,sprintf("Bandstop Filter on Gaussian (%d dB) \n Frequency Spectrum", snr_ideal));
  
       % linear averaging filter
       laf_recovery = lpf_averaging(noisy_signal);
       err_g(as,s,3) = rmse(signal, laf_recovery);
       figure;
       plot(time,laf_recovery);
       title(['Linear Lowpass Averaging Filter on Gaussian (',num2str(snr_ideal),' dB SNR)']);
       xlabel('Time (s)');
       ylabel('Amplitude');
       exportgraphics(gca,['G_laf_',num2str(snr_ideal),'_',num2str(as),'.png']);
       playSignal(laf_recovery, fs, 'LAF G');
       audiowrite(['gaussian_laf_',num2str(snr_ideal),'_',num2str(as),'.wav'],laf_recovery,fs);

       plotSpectrum(laf_recovery,fs,sprintf("Linear Lowpass Averaging Filter on Gaussian (%d dB) \n Frequency Spectrum", snr_ideal));
  
       % butterworth filter
       btw_recovery = buttfilt(noisy_signal,snr_actual_g(as,s));
       err_g(as,s,4) = rmse(signal, btw_recovery);
       figure;
       plot(time,btw_recovery);
       title(['Butterworth Filter on Gaussian (',num2str(snr_ideal),' dB SNR)']);
       xlabel('Time (s)');
       ylabel('Amplitude');
       exportgraphics(gca,['G_btw_',num2str(snr_ideal),'_',num2str(as),'.png']);
       playSignal(btw_recovery, fs, 'BTW G');
       audiowrite(['gaussian_btw_',num2str(snr_ideal),'_',num2str(as),'.wav'],btw_recovery,fs);

       plotSpectrum(btw_recovery,fs,sprintf("Butterworth Filter on Gaussian (%d dB) \n Frequency Spectrum", snr_ideal));

       % elliptical filter
       elp_recovery = ellipfilt(noisy_signal,fs);
       err_g(as,s,5) = rmse(signal, elp_recovery);
       figure;
       plot(time,elp_recovery);
       title(['Elliptical Filter on Gaussian (',num2str(snr_ideal),' dB SNR)']);
       xlabel('Time (s)');
       ylabel('Amplitude');
       exportgraphics(gca,['G_elp_',num2str(snr_ideal),'_',num2str(as),'.png']);
       playSignal(elp_recovery, fs, 'ELP G');
       audiowrite(['gaussian_elp_',num2str(snr_ideal),'_',num2str(as),'.wav'],elp_recovery,fs);

       plotSpectrum(elp_recovery,fs,sprintf("Elliptical Filter on Gaussian (%d dB) \n Frequency Spectrum", snr_ideal));
   end
  
   %% Uniform Noise
   for s = 1:3
       snr_ideal = s*5;
       [noisy_signal, snr_actual_u(as,s)]  = addUniformNoise(signal, snr_ideal, as, fs);
      
       % FIGURE: noisy audio sample
       figure;
       plot(time,noisy_signal);
       title(['Uniform Noise Audio Sample (',num2str(snr_ideal),' dB SNR)']);       
       xlabel('Time (s)');
       ylabel('Amplitude');
       exportgraphics(gca,['U_noise_',num2str(snr_ideal),'_',num2str(as),'.png']);
      
       playSignal(noisy_signal, fs, 'Uniform');
       audiowrite(['uniform_noise_',num2str(snr_ideal),'_',num2str(as),'.wav'],noisy_signal,fs);
       % Removing Noise
       % lowpass filter
       lpf_recovery = lpf(noisy_signal, snr_actual_u(as,s));
       err_u(as,s,1) = rmse(signal, lpf_recovery);
       figure;
       plot(time,lpf_recovery);
       title(['Lowpass Filter on Uniform (',num2str(snr_ideal),' dB SNR)']);       
       xlabel('Time (s)');
       ylabel('Amplitude');
       exportgraphics(gca,['U_lpf_',num2str(snr_ideal),'_',num2str(as),'.png']);
       playSignal(lpf_recovery, fs, 'LPF U');
       audiowrite(['uniform_lpf_',num2str(snr_ideal),'_',num2str(as),'.wav'],lpf_recovery,fs);
  
       % bandstop filter
       bsf_recovery = bsf(noisy_signal,snr_actual_u(as,s));
       err_u(as,s,2) = rmse(signal, bsf_recovery);
       figure;
       plot(time,bsf_recovery);
       title(['Bandstop Filter on Uniform (',num2str(snr_ideal),' dB SNR)']);       
       xlabel('Time (s)');
       ylabel('Amplitude');
       exportgraphics(gca,['U_bsf_',num2str(snr_ideal),'_',num2str(as),'.png']);
       playSignal(bsf_recovery, fs, 'BSF U');
       audiowrite(['uniform_bsf_',num2str(snr_ideal),'_',num2str(as),'.wav'],bsf_recovery,fs);
  
       % linear averaging filter
       laf_recovery = lpf_averaging(noisy_signal);
       err_u(as,s,3) = rmse(signal, laf_recovery);
      
       figure;
       plot(time,laf_recovery);
       title(['Linear Lowpass Averaging Filter on Uniform (',num2str(snr_ideal),' dB SNR)']);       
       xlabel('Time (s)');
       ylabel('Amplitude');
       exportgraphics(gca,['U_laf_',num2str(snr_ideal),'_',num2str(as),'.png']);
       playSignal(laf_recovery, fs, 'LAF U');
       audiowrite(['uniform_laf_',num2str(snr_ideal),'_',num2str(as),'.wav'],laf_recovery,fs);
  
       % butterworth filter
       btw_recovery = buttfilt(noisy_signal,snr_actual_u(as,s));
       err_u(as,s,4) = rmse(signal, btw_recovery);
      
       figure;
       plot(time,btw_recovery);
       title(['Butterworth Filter on Uniform (',num2str(snr_ideal),' dB SNR)']);       
       xlabel('Time (s)');
       ylabel('Amplitude');
       exportgraphics(gca,['U_btw_',num2str(snr_ideal),'_',num2str(as),'.png']);
      
       playSignal(btw_recovery, fs, 'BTW U');
       audiowrite(['uniform_btw_',num2str(snr_ideal),'_',num2str(as),'.wav'],btw_recovery,fs);
       % elliptical filter
       elp_recovery = ellipfilt(noisy_signal, fs);
       err_u(as,s,5) = rmse(signal, elp_recovery);
       figure;
       plot(time,elp_recovery);
       title(['Elliptical Filter on Uniform (',num2str(snr_ideal),' dB SNR)']);       
       xlabel('Time (s)');
       ylabel('Amplitude');
       exportgraphics(gca,['U_elp_',num2str(snr_ideal),'_',num2str(as),'.png']);
       playSignal(elp_recovery, fs, 'ELP U');
       audiowrite(['uniform_elp_',num2str(snr_ideal),'_',num2str(as),'.wav'],elp_recovery,fs);
   end
   %% Exponential Noise
   for s = 1:3
       snr_ideal = s*5;
       [noisy_signal, snr_actual_e(as,s)] = addExponentialNoise(signal, snr_ideal, as, fs);
      
       % FIGURE: noisy audio sample
       figure;
       plot(time,noisy_signal);
       title(['Exponential Noise Audio Sample (',num2str(snr_ideal),' dB SNR)']);       
       xlabel('Time (s)');
       ylabel('Amplitude');
       exportgraphics(gca,['E_noise_',num2str(snr_ideal),'_',num2str(as),'.png']);
       playSignal(noisy_signal, fs, 'Exponential');
       audiowrite(['exponential_noise_',num2str(snr_ideal),'_',num2str(as),'.wav'],noisy_signal,fs);
      
       % Removing Noise
       % lowpass filter
       lpf_recovery = lpf(noisy_signal, snr_actual_e(as,s));
       err_e(as,s,1) = rmse(signal, lpf_recovery);
       figure;
       plot(time,lpf_recovery);
       title(['Lowpass Filter on Exponential (',num2str(snr_ideal),' dB SNR)']);       
       xlabel('Time (s)');
       ylabel('Amplitude');
       exportgraphics(gca,['E_lpf_',num2str(snr_ideal),'_',num2str(as),'.png']);
       playSignal(lpf_recovery, fs, 'LPF E');
       audiowrite(['exponential_lpf_',num2str(snr_ideal),'_',num2str(as),'.wav'],lpf_recovery,fs);
  
       % bandstop filter
       bsf_recovery = bsf(noisy_signal,snr_actual_e(as,s));
       err_e(as,s,2) = rmse(signal, bsf_recovery);
       figure;
       plot(time,bsf_recovery);
       title(['Bandstop Filter on Exponential (',num2str(snr_ideal),' dB SNR)']);       
       xlabel('Time (s)');
       ylabel('Amplitude');
       exportgraphics(gca,['E_bsf_',num2str(snr_ideal),'_',num2str(as),'.png']);
       playSignal(bsf_recovery, fs, 'BSF E');
       audiowrite(['exponential_bsf_',num2str(snr_ideal),'_',num2str(as),'.wav'],bsf_recovery,fs);
  
       % linear averaging filter
       laf_recovery = lpf_averaging(noisy_signal);
       err_e(as,s,3) = rmse(signal, laf_recovery);
       figure;
       plot(time,laf_recovery);
       title(['Linear Lowpass Averaging Filter on Exponential (',num2str(snr_ideal),' dB SNR)']);       
       xlabel('Time (s)');
       ylabel('Amplitude');
       exportgraphics(gca,['E_laf_',num2str(snr_ideal),'_',num2str(as),'.png']);
       playSignal(laf_recovery, fs, 'LAF E');
       audiowrite(['exponential_laf_',num2str(snr_ideal),'_',num2str(as),'.wav'],laf_recovery,fs);
  
       % butterworth filter
       btw_recovery = buttfilt(noisy_signal,snr_actual_e(as,s));
       err_e(as,s,4) = rmse(signal, btw_recovery);
       figure;
       plot(time,btw_recovery);
       title(['Butterworth Filter on Exponential (',num2str(snr_ideal),' dB SNR)']);       
       xlabel('Time (s)');
       ylabel('Amplitude');
       exportgraphics(gca,['E_btw_',num2str(snr_ideal),'_',num2str(as),'.png']);
       playSignal(btw_recovery, fs, 'BTW E');
       audiowrite(['exponential_btw_',num2str(snr_ideal),'_',num2str(as),'.wav'],btw_recovery,fs);
              
       % elliptical filter
       elp_recovery = ellipfilt(noisy_signal,fs);
       err_e(as,s,5) = rmse(signal, elp_recovery);
       figure;
       plot(time,elp_recovery);
       title(['Elliptical Filter on Exponential (',num2str(snr_ideal),' dB SNR)']);       
       xlabel('Time (s)');
       ylabel('Amplitude');
       exportgraphics(gca,['E_elp_',num2str(snr_ideal),'_',num2str(as),'.png']);
       playSignal(elp_recovery, fs, 'ELP E');
       audiowrite(['exponential_elp_',num2str(snr_ideal),'_',num2str(as),'.wav'],elp_recovery,fs);
   end
   %% Rayleigh Noise
   for s = 1:3
       snr_ideal = s*5;
       [noisy_signal, snr_actual_r(as,s)] = addRayleighNoise(signal, snr_ideal, as, fs);
       % FIGURE: noisy audio sample
       figure;
       plot(time,noisy_signal);
       title(['Rayleigh Noise Audio Sample (',num2str(snr_ideal),' dB SNR)']);       
       xlabel('Time (s)');
       ylabel('Amplitude');
       exportgraphics(gca,['R_noise_',num2str(snr_ideal),'_',num2str(as),'.png']);
       playSignal(noisy_signal, fs, 'Rayleigh');
       audiowrite(['rayleigh_noise_',num2str(snr_ideal),'_',num2str(as),'.wav'],noisy_signal,fs);
       % Removing Noise
       % lowpass filter
       lpf_recovery = lpf(noisy_signal, snr_actual_r(as,s));
       err_r(as,s,1) = rmse(signal, lpf_recovery);
  
       figure;
       plot(time,lpf_recovery);
       title(['Lowpass Filter on Rayleigh (',num2str(snr_ideal),' dB SNR)']);       
       xlabel('Time (s)');
       ylabel('Amplitude');
       exportgraphics(gca,['R_lpf_',num2str(snr_ideal),'_',num2str(as),'.png']);
       playSignal(lpf_recovery, fs, 'LPF R');
       audiowrite(['rayleigh_lpf_',num2str(snr_ideal),'_',num2str(as),'.wav'],lpf_recovery,fs);
       % bandstop filter
       bsf_recovery = bsf(noisy_signal,snr_actual_r(as,s));
       err_r(as,s,2) = rmse(signal, bsf_recovery);
      
       figure;
       plot(time,bsf_recovery);
       title(['Bandstop Filter on Rayleigh (',num2str(snr_ideal),' dB SNR)']);       
       xlabel('Time (s)');
       ylabel('Amplitude');
       exportgraphics(gca,['R_bsf_',num2str(snr_ideal),'_',num2str(as),'.png']);
       playSignal(bsf_recovery, fs, 'BSF R');
       audiowrite(['rayleigh_bsf_',num2str(snr_ideal),'_',num2str(as),'.wav'],bsf_recovery,fs);
       % linear averaging filter
       laf_recovery = lpf_averaging(noisy_signal);
       err_r(as,s,3) = rmse(signal, laf_recovery);
      
       figure;
       plot(time,laf_recovery);
       title(['Linear Low-Pass Average Filter on Rayleigh (',num2str(snr_ideal),' dB SNR)']);       
       xlabel('Time (s)');
       ylabel('Amplitude');
       exportgraphics(gca,['R_laf_',num2str(snr_ideal),'_',num2str(as),'.png']);
       playSignal(laf_recovery, fs, 'LAF R');
       audiowrite(['rayleigh_laf_',num2str(snr_ideal),'_',num2str(as),'.wav'],laf_recovery,fs);
  
       % butterworth filter
       btw_recovery = buttfilt(noisy_signal,snr_actual_r(as,s));
       err_r(as,s,4) = rmse(signal, btw_recovery);
      
       figure;
       plot(time,btw_recovery);
       title(['Butterworth Filter on Rayleigh (',num2str(snr_ideal),' dB SNR)']);       
       xlabel('Time (s)');
       ylabel('Amplitude');
       exportgraphics(gca,['R_btw_',num2str(snr_ideal),'_',num2str(as),'.png']);
       playSignal(btw_recovery, fs, 'BTW R');
       audiowrite(['rayleigh_btw_',num2str(snr_ideal),'_',num2str(as),'.wav'],btw_recovery,fs);
             
       % elliptical filter
       elp_recovery = ellipfilt(noisy_signal,fs);
       err_r(as,s,5) = rmse(signal, elp_recovery);
       figure;
       plot(time,elp_recovery);
       title(['Elliptical Filter on Rayleigh (',num2str(snr_ideal),' dB SNR)']);       
       xlabel('Time (s)');
       ylabel('Amplitude');
       exportgraphics(gca,['R_elp_',num2str(snr_ideal),'_',num2str(as),'.png']);
       playSignal(elp_recovery, fs, 'ELP R');
       audiowrite(['rayleigh_elp_',num2str(snr_ideal),'_',num2str(as),'.wav'],elp_recovery,fs);
   end
  
   %% Traffic Noise
   % only one snr
   s = 1;
   [noisy_signal, snr_actual_t(as,s)] = addTrafficNoise(signal, fs, as);
  
   % FIGURE: noisy audio sample
   figure;
   plot(time,noisy_signal);
   title(['Traffic Noise Audio Sample (',num2str(round(snr_actual_t(as,s))),' dB SNR)']);       
   xlabel('Time (s)');
   ylabel('Amplitude');
   exportgraphics(gca,['T_noise_',num2str(round(snr_actual_t(as,s))),'_',num2str(as),'.png']);
  
   playSignal(noisy_signal, fs, 'Traffic');
   audiowrite(['traffic_noise_',num2str(round(snr_actual_t(as,s))),'_',num2str(as),'.wav'],noisy_signal,fs);
  
   % Removing Noise
   % lowpass filter
   lpf_recovery = lpf(noisy_signal, snr_actual_t(as,s));
   err_t(as,s,1) = rmse(signal, lpf_recovery);
   figure;
   plot(time,lpf_recovery);
   title(['Lowpass Filter on Traffic (',num2str(round(snr_actual_t(as,s))),' dB SNR)']);
   xlabel('Time (s)');
   ylabel('Amplitude');
   exportgraphics(gca,['T_lpf_',num2str(round(snr_actual_t(as,s))),'_',num2str(as),'.png']);
   playSignal(lpf_recovery, fs, 'LPF T');
   audiowrite(['traffic_lpf_',num2str(round(snr_actual_t(as,s))),'_',num2str(as),'.wav'],lpf_recovery,fs);
   % bandstop filter
   bsf_recovery = bsf(noisy_signal,snr_actual_t(as,s));
   err_t(as,s,2) = rmse(signal, bsf_recovery);
   figure;
   plot(time,bsf_recovery);
   title(['Bandstop Filter on Traffic (',num2str(round(snr_actual_t(as,s))),' dB SNR)']);
   xlabel('Time (s)');
   ylabel('Amplitude');
   exportgraphics(gca,['T_bsf_',num2str(round(snr_actual_t(as,s))),'_',num2str(as),'.png']);
   playSignal(bsf_recovery, fs, 'BSF T');
   audiowrite(['traffic_bsf_',num2str(round(snr_actual_t(as,s))),'_',num2str(as),'.wav'],bsf_recovery,fs);
   % linear averaging filter
   laf_recovery = lpf_averaging(noisy_signal);
   err_t(as,s,3) = rmse(signal, laf_recovery);
   figure;
   plot(time,laf_recovery);
   title(['Linear Low-Pass Average Filter on Traffic (',num2str(round(snr_actual_t(as,s))),' dB SNR)']);
   xlabel('Time (s)');
   ylabel('Amplitude');
   exportgraphics(gca,['T_laf_',num2str(round(snr_actual_t(as,s))),'_',num2str(as),'.png']);
   playSignal(laf_recovery, fs, 'LAF T');
   audiowrite(['traffic_laf_',num2str(round(snr_actual_t(as,s))),'_',num2str(as),'.wav'],laf_recovery,fs);
   % butterworth filter
   btw_recovery = buttfilt(noisy_signal,snr_actual_t(as,s));
   err_t(as,s,4) = rmse(signal, btw_recovery);
  
   figure;
   plot(time,btw_recovery);
   title(['Butterworth Filter on Traffic (',num2str(round(snr_actual_t(as,s))),' dB SNR)']);
   xlabel('Time (s)');
   ylabel('Amplitude');
   exportgraphics(gca,['T_btw_',num2str(round(snr_actual_t(as,s))),'_',num2str(as),'.png']);
   playSignal(btw_recovery, fs, 'BTW T');
   audiowrite(['traffic_btw_',num2str(round(snr_actual_t(as,s))),'_',num2str(as),'.wav'],btw_recovery,fs);
         
   % elliptical filter
   elp_recovery = ellipfilt(noisy_signal,fs);
   err_t(as,s,5) = rmse(signal, elp_recovery);
   figure;
   plot(time,elp_recovery);
   title(['Elliptical Filter on Traffic (',num2str(round(snr_actual_t(as,s))),' dB SNR)']);
   xlabel('Time (s)');
   ylabel('Amplitude');
   exportgraphics(gca,['T_elp_',num2str(round(snr_actual_t(as,s))),'_',num2str(as),'.png']);
   playSignal(elp_recovery, fs, 'ELP T');
   audiowrite(['traffic_elp_',num2str(round(snr_actual_t(as,s))),'_',num2str(as),'.wav'],elp_recovery,fs);
   %% Background Conversation Noise
   % only one snr
   s = 1;
   [noisy_signal, snr_actual_c(as,s)] = addConversationNoise(signal, fs, as);
   % FIGURE: noisy audio sample
   figure;
   plot(time,noisy_signal);
   title(['Background Conversation Noise Audio Sample (',num2str(round(snr_actual_c(as,s))),' dB SNR)']);
   xlabel('Time (s)');
   ylabel('Amplitude');
   exportgraphics(gca,['C_noise_',num2str(round(snr_actual_c(as,s))),'_',num2str(as),'.png']);
   playSignal(noisy_signal, fs, 'Conversation');
   audiowrite(['conversation_noise_',num2str(round(snr_actual_c(as,s))),'_',num2str(as),'.wav'],noisy_signal,fs);
   % Removing Noise
   % lowpass filter
   lpf_recovery = lpf(noisy_signal, snr_actual_c(as,s));
   err_c(as,s,1) = rmse(signal, lpf_recovery);
   figure;
   plot(time,lpf_recovery);
   title(['Lowpass Filter on Background Conversation (',num2str(round(snr_actual_c(as,s))),' dB SNR)']);
   xlabel('Time (s)');
   ylabel('Amplitude');
   exportgraphics(gca,['C_lpf_',num2str(round(snr_actual_c(as,s))),'_',num2str(as),'.png']);
   playSignal(lpf_recovery, fs, 'LPF C');
   audiowrite(['conversation_lpf_',num2str(round(snr_actual_c(as,s))),'_',num2str(as),'.wav'],lpf_recovery,fs);
   % bandstop filter
   bsf_recovery = bsf(noisy_signal,snr_actual_c(as,s));
   err_c(as,s,2) = rmse(signal, bsf_recovery);
   figure;
   plot(time,bsf_recovery);
   title(['Bandstop Filter on Background Conversation (',num2str(round(snr_actual_c(as,s))),' dB SNR)']);
   xlabel('Time (s)');
   ylabel('Amplitude');
   exportgraphics(gca,['C_bsf_',num2str(round(snr_actual_c(as,s))),'_',num2str(as),'.png']);
   playSignal(bsf_recovery, fs, 'BSF C');
   audiowrite(['conversation_bsf_',num2str(round(snr_actual_c(as,s))),'_',num2str(as),'.wav'],bsf_recovery,fs);
   % linear averaging filter
   laf_recovery = lpf_averaging(noisy_signal);
   err_c(as,s,3) = rmse(signal, laf_recovery);
   figure;
   plot(time,laf_recovery);
   title(['Linear Low-Pass Average Filter on Background Conversation (',num2str(round(snr_actual_c(as,s))),' dB SNR)']);
   xlabel('Time (s)');
   ylabel('Amplitude');
   exportgraphics(gca,['C_laf_',num2str(round(snr_actual_c(as,s))),'_',num2str(as),'.png']);
   playSignal(laf_recovery, fs, 'LAF C');
   audiowrite(['conversation_laf_',num2str(round(snr_actual_c(as,s))),'_',num2str(as),'.wav'],laf_recovery,fs);
   % butterworth filter
   btw_recovery = buttfilt(noisy_signal,snr_actual_c(as,s));
   err_c(as,s,4) = rmse(signal, btw_recovery);
   
   figure;
   plot(time,btw_recovery);
   title(['Butterworth Filter on Background Conversation (',num2str(round(snr_actual_c(as,s))),' dB SNR)']);
   xlabel('Time (s)');
   ylabel('Amplitude');
   exportgraphics(gca,['C_btw_',num2str(round(snr_actual_c(as,s))),'_',num2str(as),'.png']);
   playSignal(btw_recovery, fs, 'BTW C');
   audiowrite(['conversation_btw_',num2str(round(snr_actual_c(as,s))),'_',num2str(as),'.wav'],btw_recovery,fs);
         
   % elliptical filter
   elp_recovery = ellipfilt(noisy_signal,fs);
   err_c(as,s,5) = rmse(signal, elp_recovery);
   figure;
   plot(time,elp_recovery);
   title(['Elliptical Filter on Background Conversation (',num2str(round(snr_actual_c(as,s))),' dB SNR)']);
   xlabel('Time (s)');
   ylabel('Amplitude');
   exportgraphics(gca,['C_elp_',num2str(round(snr_actual_c(as,s))),'_',num2str(as),'.png']);
   playSignal(elp_recovery, fs, 'ELP C');
   audiowrite(['conversation_elp_',num2str(round(snr_actual_c(as,s))),'_',num2str(as),'.wav'],elp_recovery,fs);
end
