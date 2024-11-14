%% Final Project Script
% Lucia Torres, Breanna Mapes, Ayano Ueki

%% Load in Clean Samples
% Lucia audio sample
[signal_l, fs] = audioread('lucia_clean.wav'); % load in audio sample
signal_l = signal_l(:,1); % one dimensional array

% FIGURE: original audio sample
figure;
plot(signal_l);
title('Original Audio Sample');
audio_sample = audioplayer(signal_l, fs);
playblocking(audio_sample);

% Cody audio sample
[signal_c, fs] = audioread('cody_clean.wav'); % load in audio sample
signal_c = signal_c(:,1); % one dimensional array

% FIGURE: original audio sample
figure;
plot(signal_c);
title('Original Audio Sample');
audio_sample = audioplayer(signal_c, fs);
playblocking(audio_sample);

for as = 1:2
    % determine audio sample
    if as == 1
        signal = signal_l;
    else
        signal = signal_c;
    end

    %% Gaussian Noise
    snr_actual_g = zeros(1,3);
    err_g = zeros(3,4); % rows: snr | col: rmse
    for s = 1:3
        snr_ideal = s*5;
        noisy_signal = addGaussianNoise(signal, snr_ideal);
        snr_actual_g(s) = snr(signal, noisy_signal);
       
        % FIGURE: noisy audio sample
        figure;
        plot(noisy_signal);
        title('Gaussian Noise Audio Sample');
        noisy_audio_sample = audioplayer(noisy_signal, fs);
        playblocking(noisy_audio_sample);
        
        % Removing Noise
        % lowpass filter
        wpass;
        lpf_recovery = lowpass(noisy_signal, wpass);
        err_g(s,1) = rmse(signal, lpf_recovery);
    
        figure;
        plot(lpf_recovery);
        title('Lowpass Filter');
        lpf_audio_sample = audioplayer(lpf_recovery, fs);
        playblocking(lpf_audio_sample);
        
        % bandstop filter
        wpass;
        bsf_recovery = bandstop(noisy_signal,wpass);
        err_g(s,2) = rmse(signal, bsf_recovery);

        figure;
        plot(bsf_recovery);
        title('Bandstop Filter');
        bsf_audio_sample = audioplayer(bsf_recovery, fs);
        playblocking(bsf_audio_sample);
    
        % linear averaging filter
        laf_recovery = lpf_averaging(noisy_signal);
        err_g(s,3) = rmse(signal, laf_recovery);

        figure;
        plot(laf_recovery);
        title('Linear Lowpass Averaging Filter');
        laf_audio_sample = audioplayer(laf_recovery, fs);
        playblocking(laf_audio_sample);
    
        % butterworth filter
        btw_recovery = buttfilt(noisy_signal,snr_actual);
        err_g(s,4) = rmse(signal, btw_recovery);

        figure;
        plot(btw_recovery);
        title('Butterworth Filter');
        btw_audio_sample = audioplayer(btw_recovery, fs);
        playblocking(btw_audio_sample);
    end
    
    %% Uniform Noise
    snr_actual_u = zeros(1,3);
    err_u = zeros(3,4); % rows: snr | col: rmse
    for s = 1:3
        snr_ideal = s*5;
        noisy_signal = addUniformNoise(signal, snr_ideal);
        snr_actual_u(s) = snr(signal, noisy_signal);
        
        % FIGURE: noisy audio sample
        figure;
        plot(noisy_signal);
        title('Uniform Noise Audio Sample');
        noisy_audio_sample = audioplayer(noisy_signal, fs);
        playblocking(noisy_audio_sample);
        
        % Removing Noise
        % lowpass filter
        wpass;
        lpf_recovery = lowpass(noisy_signal, wpass);
        err_u(s,1) = rmse(signal, lpf_recovery);

        figure;
        plot(lpf_recovery);
        title('Lowpass Filter');
        lpf_audio_sample = audioplayer(lpf_recovery, fs);
        playblocking(lpf_audio_sample);
    
        % bandstop filter
        wpass;
        bsf_recovery = bandstop(noisy_signal,wpass);
        err_u(s,2) = rmse(signal, bsf_recovery);

        figure;
        plot(bsf_recovery);
        title('Bandstop Filter');
        bsf_audio_sample = audioplayer(bsf_recovery, fs);
        playblocking(bsf_audio_sample);
    
        % linear averaging filter
        laf_recovery = lpf_averaging(noisy_signal);
        err_u(s,3) = rmse(signal, laf_recovery);
        
        figure;
        plot(laf_recovery);
        title('Linear Lowpass Averaging Filter');
        laf_audio_sample = audioplayer(laf_recovery, fs);
        playblocking(laf_audio_sample);
    
        % butterworth filter
        btw_recovery = buttfilt(noisy_signal,snr_actual);
        err_u(s,4) = rmse(signal, btw_recovery);
        
        figure;
        plot(btw_recovery);
        title('Butterworth Filter');
        btw_audio_sample = audioplayer(btw_recovery, fs);
        playblocking(btw_audio_sample);
    end

    %% Exponential Noise
    snr_actual_e = zeros(1,3);
    err_e = zeros(3,4); % rows: snr | col: rmse
    for s = 1:3
        snr_ideal = s*5;
        noisy_signal = addUniformNoise(signal, snr_ideal);
        snr_actual_e(s) = snr(signal, noisy_signal);
        
        % FIGURE: noisy audio sample
        figure;
        plot(noisy_signal);
        title('Exponential Noise Audio Sample');
        noisy_audio_sample = audioplayer(noisy_signal, fs);
        playblocking(noisy_audio_sample);
        
        % Removing Noise
        % lowpass filter
        wpass;
        lpf_recovery = lowpass(noisy_signal, wpass);
        err_e(s,1) = rmse(signal, lpf_recovery);

        figure;
        plot(lpf_recovery);
        title('Lowpass Filter');
        lpf_audio_sample = audioplayer(lpf_recovery, fs);
        playblocking(lpf_audio_sample);
    
        % bandstop filter
        wpass;
        bsf_recovery = bandstop(noisy_signal,wpass);
        err_e(s,2) = rmse(signal, bsf_recovery);

        figure;
        plot(bsf_recovery);
        title('Bandstop Filter');
        bsf_audio_sample = audioplayer(bsf_recovery, fs);
        playblocking(bsf_audio_sample);
    
        % linear averaging filter
        laf_recovery = lpf_averaging(noisy_signal);
        err_e(s,3) = rmse(signal, laf_recovery);

        figure;
        plot(laf_recovery);
        title('Linear Lowpass Averaging Filter');
        laf_audio_sample = audioplayer(laf_recovery, fs);
        playblocking(laf_audio_sample);
    
        % butterworth filter
        btw_recovery = buttfilt(noisy_signal,snr_actual);
        err_e(s,4) = rmse(signal, btw_recovery);

        figure;
        plot(btw_recovery);
        title('Butterworth Filter');
        btw_audio_sample = audioplayer(btw_recovery, fs);
        playblocking(btw_audio_sample);
    end

    %% Rayleigh Noise
    snr_actual_r = zeros(1,3);
    err_r = zeros(3,4); % rows: snr | col: rmse
    for s = 1:3
        snr_ideal = s*5;
        noisy_signal = addUniformNoise(signal, snr_ideal);
        snr_actual_r(s) = snr(signal, noisy_signal);

        % FIGURE: noisy audio sample
        figure;
        plot(noisy_signal);
        title('Rayleigh Noise Audio Sample');
        noisy_audio_sample = audioplayer(noisy_signal, fs);
        playblocking(noisy_audio_sample);

        % Removing Noise
        % lowpass filter
        wpass;
        lpf_recovery = lowpass(noisy_signal, wpass);
        err_r(s,1) = rmse(signal, lpf_recovery);
    
        figure;
        plot(lpf_recovery);
        title('Lowpass Filter');
        lpf_audio_sample = audioplayer(lpf_recovery, fs);
        playblocking(lpf_audio_sample);

        % bandstop filter
        wpass;
        bsf_recovery = bandstop(noisy_signal,wpass);
        err_r(s,2) = rmse(signal, bsf_recovery);
        
        figure;
        plot(bsf_recovery);
        title('Bandstop Filter');
        bsf_audio_sample = audioplayer(bsf_recovery, fs);
        playblocking(bsf_audio_sample);

        % linear averaging filter
        laf_recovery = lpf_averaging(noisy_signal);
        err_r(s,3) = rmse(signal, laf_recovery);
        
        figure;
        plot(laf_recovery);
        title('Linear Low-Pass Average Filter');
        laf_audio_sample = audioplayer(laf_recovery, fs);
        playblocking(laf_audio_sample);
    
        % butterworth filter
        btw_recovery = buttfilt(noisy_signal,snr_actual);
        err_r(s,4) = rmse(signal, btw_recovery);
        
        figure;
        plot(btw_recovery);
        title('Butterworth Filter');
        btw_audio_sample = audioplayer(btw_recovery, fs);
        playblocking(btw_audio_sample);
    end

    %% Traffic Noise
    snr_actual_t = zeros(1,3);
    err_t = zeros(3,4); % rows: snr | col: rmse
    for s = 1:3
        snr_ideal = s*5;
        noisy_signal = addUniformNoise(signal, snr_ideal);
        snr_actual_t(s) = snr(signal, noisy_signal);
        
        % FIGURE: noisy audio sample
        figure;
        plot(noisy_signal);
        title('Traffic Noise Audio Sample');
        noisy_audio_sample = audioplayer(noisy_signal, fs);
        playblocking(noisy_audio_sample);
        
        % Removing Noise
        % lowpass filter
        wpass;
        lpf_recovery = lowpass(noisy_signal, wpass);
        err_t(s,1) = rmse(signal, lpf_recovery);

        figure;
        plot(lpf_recovery);
        title('Lowpass Filter');
        lpf_audio_sample = audioplayer(lpf_recovery, fs);
        playblocking(lpf_audio_sample);
    
        % bandstop filter
        wpass;
        bsf_recovery = bandstop(noisy_signal,wpass);
        err_t(s,2) = rmse(signal, bsf_recovery);

        figure;
        plot(bsf_recovery);
        title('Bandstop Filter');
        bsf_audio_sample = audioplayer(bsf_recovery, fs);
        playblocking(bsf_audio_sample);
    
        % linear averaging filter
        laf_recovery = lpf_averaging(noisy_signal);
        err_t(s,3) = rmse(signal, laf_recovery);

        figure;
        plot(laf_recovery);
        title('Linear Low-Pass Average Filter');
        laf_audio_sample = audioplayer(laf_recovery, fs);
        playblocking(laf_audio_sample);
    
        % butterworth filter
        btw_recovery = buttfilt(noisy_signal,snr_actual);
        err_t(s,4) = rmse(signal, btw_recovery);
        
        figure;
        plot(btw_recovery);
        title('Butterworth Filter');
        btw_audio_sample = audioplayer(btw_recovery, fs);
        playblocking(btw_audio_sample);
    end

    %% Background Conversation Noise
    snr_actual_b = zeros(1,3);
    err_b = zeros(3,4); % rows: snr | col: rmse
    for s = 1:3
        snr_ideal = s*5;
        noisy_signal = addUniformNoise(signal, snr_ideal);
        snr_actual_b(s) = snr(signal, noisy_signal);

        % FIGURE: noisy audio sample
        figure;
        plot(noisy_signal);
        title('Background Conversation Noise Audio Sample');
        noisy_audio_sample = audioplayer(noisy_signal, fs);
        playblocking(noisy_audio_sample);
    
        % Removing Noise
        % lowpass filter
        wpass;
        lpf_recovery = lowpass(noisy_signal, wpass);
        err_b(s,1) = rmse(signal, lpf_recovery);

        figure;
        plot(lpf_recovery);
        title('Lowpass Filter');
        lpf_audio_sample = audioplayer(lpf_recovery, fs);
        playblocking(lpf_audio_sample);
    
        % bandstop filter
        wpass;
        bsf_recovery = bandstop(noisy_signal,wpass);
        err_b(s,2) = rmse(signal, bsf_recovery);

        figure;
        plot(bsf_recovery);
        title('Bandstop Filter');
        bsf_audio_sample = audioplayer(bsf_recovery, fs);
        playblocking(bsf_audio_sample);
    
        % linear averaging filter
        laf_recovery = lpf_averaging(noisy_signal);
        err_b(s,3) = rmse(signal, laf_recovery);

        figure;
        plot(laf_recovery);
        title('Linear Low-Pass Average Filter');
        laf_audio_sample = audioplayer(laf_recovery, fs);
        playblocking(laf_audio_sample);
    
        % butterworth filter
        btw_recovery = buttfilt(noisy_signal,snr_actual);
        err_b(s,4) = rmse(signal, btw_recovery);
         
        figure;
        plot(btw_recovery);
        title('Butterworth Filter');
        btw_audio_sample = audioplayer(btw_recovery, fs);
        playblocking(btw_audio_sample);
    end
end