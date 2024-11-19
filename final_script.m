%% Final Project Script
% Lucia Torres, Breanna Mapes, Ayano Ueki

%% Load in Clean Samples
% Lucia audio sample
[signal_l, fs] = audioread('lucia_clean.wav'); % load in audio sample
signal_l = signal_l(:,1); % one dimensional array
signal_l = signal_l / max(signal_l);

% FIGURE: original audio sample
figure;
plot(signal_l);
title('Original Audio Sample');
audio_sample = audioplayer(signal_l, fs);
playblocking(audio_sample);

% Cody audio sample
[signal_c, fs] = audioread('cody_clean.wav'); % load in audio sample
signal_c = signal_c(:,1); % one dimensional array
signal_c = signal_c / max(signal_c);

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
    snr_actual_g = zeros(2,3);
    err_g = zeros(3,5); % rows: snr | col: rmse
    for s = 1:3
        snr_ideal = s*5;
        [noisy_signal, snr_actual_g(s)] = addGaussianNoise(signal, snr_ideal);
       
        % FIGURE: noisy audio sample
        figure;
        plot(noisy_signal);
        title('Gaussian Noise Audio Sample');
        noisy_audio_sample = audioplayer(noisy_signal, fs);
        playblocking(noisy_audio_sample);
        audiowrite(['gaussian_noise_',num2str(s),'.wav'],noisy_signal,fs);
        
        % Removing Noise
        % lowpass filter
        lpf_recovery = lpf(noisy_signal, snr_actual_g(s));
        err_g(s,1) = rmse(signal, lpf_recovery);
    
        figure;
        plot(lpf_recovery);
        title('Lowpass Filter');
        lpf_audio_sample = audioplayer(lpf_recovery, fs);
        playblocking(lpf_audio_sample);
        audiowrite('gaussian_lpf_',num2str(s),'.wav',lpf_recovery,fs);
        
        % bandstop filter
        bsf_recovery = bsf(noisy_signal,snr_actual_g(s));
        err_g(s,2) = rmse(signal, bsf_recovery);

        figure;
        plot(bsf_recovery);
        title('Bandstop Filter');
        bsf_audio_sample = audioplayer(bsf_recovery, fs);
        playblocking(bsf_audio_sample);
        audiowrite('gaussian_bsf_',num2str(s),'.wav',bsf_recovery,fs);
    
        % linear averaging filter
        laf_recovery = lpf_averaging(noisy_signal);
        err_g(s,3) = rmse(signal, laf_recovery);

        figure;
        plot(laf_recovery);
        title('Linear Lowpass Averaging Filter');
        laf_audio_sample = audioplayer(laf_recovery, fs);
        playblocking(laf_audio_sample);
        audiowrite('gaussian_laf_',num2str(s),'.wav',laf_recovery,fs);
    
        % butterworth filter
        btw_recovery = buttfilt(noisy_signal,snr_actual_g(s));
        err_g(s,4) = rmse(signal, btw_recovery);

        figure;
        plot(btw_recovery);
        title('Butterworth Filter');
        btw_audio_sample = audioplayer(btw_recovery, fs);
        playblocking(btw_audio_sample);
        audiowrite('gaussian_btw_',num2str(s),'.wav',btw_recovery,fs);

        % elliptical filter
        elp_recovery = ellipfilt(noisy_signal,fs);
        err_g(s,5) = rmse(signal, elp_recovery);

        figure;
        plot(elp_recovery);
        title('Elliptical Filter');
        elp_audio_sample = audioplayer(elp_recovery, fs);
        playblocking(elp_audio_sample);
        audiowrite('gaussian_elp_',num2str(s),'.wav',elp_recovery,fs);
    end
    
    %% Uniform Noise
    snr_actual_u = zeros(2,3);
    err_u = zeros(3,5); % rows: snr | col: rmse
    for s = 1:3
        snr_ideal = s*5;
        [noisy_signal, snr_actual_u(s)]  = addUniformNoise(signal, snr_ideal);
        
        % FIGURE: noisy audio sample
        figure;
        plot(noisy_signal);
        title('Uniform Noise Audio Sample');
        noisy_audio_sample = audioplayer(noisy_signal, fs);
        playblocking(noisy_audio_sample);
        audiowrite('uniform_noise_',num2str(s),'.wav',noisy_signal,fs);

        
        % Removing Noise
        % lowpass filter
        lpf_recovery = lowpass(noisy_signal, snr_actual_u(s));
        err_u(s,1) = rmse(signal, lpf_recovery);

        figure;
        plot(lpf_recovery);
        title('Lowpass Filter');
        lpf_audio_sample = audioplayer(lpf_recovery, fs);
        playblocking(lpf_audio_sample);
        audiowrite('uniform_lpf_',num2str(s),'.wav',lpf_recovery,fs);

    
        % bandstop filter
        bsf_recovery = bandstop(noisy_signal,snr_actual_u(s));
        err_u(s,2) = rmse(signal, bsf_recovery);

        figure;
        plot(bsf_recovery);
        title('Bandstop Filter');
        bsf_audio_sample = audioplayer(bsf_recovery, fs);
        playblocking(bsf_audio_sample);
        audiowrite('uniform_bsf_',num2str(s),'.wav',bsf_recovery,fs);
    
        % linear averaging filter
        laf_recovery = lpf_averaging(noisy_signal);
        err_u(s,3) = rmse(signal, laf_recovery);
        
        figure;
        plot(laf_recovery);
        title('Linear Lowpass Averaging Filter');
        laf_audio_sample = audioplayer(laf_recovery, fs);
        playblocking(laf_audio_sample);
        audiowrite('uniform_laf_',num2str(s),'.wav',laf_recovery,fs);
    
        % butterworth filter
        btw_recovery = buttfilt(noisy_signal,snr_actual_u(s));
        err_u(s,4) = rmse(signal, btw_recovery);
        
        figure;
        plot(btw_recovery);
        title('Butterworth Filter');
        btw_audio_sample = audioplayer(btw_recovery, fs);
        playblocking(btw_audio_sample);
        audiowrite('uniform_btw_',num2str(s),'.wav',btw_recovery,fs);

        % elliptical filter
        elp_recovery = ellipfilt(noisy_signal, fs);
        err_g(s,5) = rmse(signal, elp_recovery);

        figure;
        plot(elp_recovery);
        title('Elliptical Filter');
        elp_audio_sample = audioplayer(elp_recovery, fs);
        playblocking(elp_audio_sample);
        audiowrite('uniform_elp_',num2str(s),'.wav',elp_recovery,fs);
    end

    %% Exponential Noise
    snr_actual_e = zeros(2,3);
    err_e = zeros(3,5); % rows: snr | col: rmse
    for s = 1:3
        snr_ideal = s*5;
        [noisy_signal, snr_actual_e(s)] = addExponentialNoise(signal, snr_ideal);
        
        % FIGURE: noisy audio sample
        figure;
        plot(noisy_signal);
        title('Exponential Noise Audio Sample');
        noisy_audio_sample = audioplayer(noisy_signal, fs);
        playblocking(noisy_audio_sample);
        audiowrite('exponential_noise_',num2str(s),'.wav',noisy_signal,fs);
        
        % Removing Noise
        % lowpass filter
        lpf_recovery = lowpass(noisy_signal, snr_actual_e(s));
        err_e(s,1) = rmse(signal, lpf_recovery);

        figure;
        plot(lpf_recovery);
        title('Lowpass Filter');
        lpf_audio_sample = audioplayer(lpf_recovery, fs);
        playblocking(lpf_audio_sample);
        audiowrite('exponential_lpf_',num2str(s),'.wav',lpf_recovery,fs);
    
        % bandstop filter
        bsf_recovery = bandstop(noisy_signal,snr_actual_e(s));
        err_e(s,2) = rmse(signal, bsf_recovery);

        figure;
        plot(bsf_recovery);
        title('Bandstop Filter');
        bsf_audio_sample = audioplayer(bsf_recovery, fs);
        playblocking(bsf_audio_sample);
        audiowrite('exponential_bsf_',num2str(s),'.wav',bsf_recovery,fs);
    
        % linear averaging filter
        laf_recovery = lpf_averaging(noisy_signal);
        err_e(s,3) = rmse(signal, laf_recovery);

        figure;
        plot(laf_recovery);
        title('Linear Lowpass Averaging Filter');
        laf_audio_sample = audioplayer(laf_recovery, fs);
        playblocking(laf_audio_sample);
        audiowrite('exponential_laf_',num2str(s),'.wav',laf_recovery,fs);
    
        % butterworth filter
        btw_recovery = buttfilt(noisy_signal,snr_actual_e(s));
        err_e(s,4) = rmse(signal, btw_recovery);

        figure;
        plot(btw_recovery);
        title('Butterworth Filter');
        btw_audio_sample = audioplayer(btw_recovery, fs);
        playblocking(btw_audio_sample);
        audiowrite('exponential_btw_',num2str(s),'.wav',btw_recovery,fs);
                
        % elliptical filter
        elp_recovery = ellipfilt(noisy_signal,fs);
        err_g(s,5) = rmse(signal, elp_recovery);

        figure;
        plot(elp_recovery);
        title('Elliptical Filter');
        elp_audio_sample = audioplayer(elp_recovery, fs);
        playblocking(elp_audio_sample);
        audiowrite('exponential_elp_',num2str(s),'.wav',elp_recovery,fs);
    end

    %% Rayleigh Noise
    snr_actual_r = zeros(2,3);
    err_r = zeros(3,5); % rows: snr | col: rmse
    for s = 1:3
        snr_ideal = s*5;
        [noisy_signal, snr_actual_r(s)] = addRayleighNoise(signal, snr_ideal);

        % FIGURE: noisy audio sample
        figure;
        plot(noisy_signal);
        title('Rayleigh Noise Audio Sample');
        noisy_audio_sample = audioplayer(noisy_signal, fs);
        playblocking(noisy_audio_sample);
        audiowrite('rayleigh_noise_',num2str(s),'.wav',noisy_signal,fs);

        % Removing Noise
        % lowpass filter
        lpf_recovery = lowpass(noisy_signal, snr_actual_r(s));
        err_r(s,1) = rmse(signal, lpf_recovery);
    
        figure;
        plot(lpf_recovery);
        title('Lowpass Filter');
        lpf_audio_sample = audioplayer(lpf_recovery, fs);
        playblocking(lpf_audio_sample);
        audiowrite('rayleigh_lpf_',num2str(s),'.wav',lpf_recovery,fs);

        % bandstop filter
        bsf_recovery = bandstop(noisy_signal,snr_actual_r(s));
        err_r(s,2) = rmse(signal, bsf_recovery);
        
        figure;
        plot(bsf_recovery);
        title('Bandstop Filter');
        bsf_audio_sample = audioplayer(bsf_recovery, fs);
        playblocking(bsf_audio_sample);
        audiowrite('rayleigh_bsf_',num2str(s),'.wav',bsf_recovery,fs);

        % linear averaging filter
        laf_recovery = lpf_averaging(noisy_signal);
        err_r(s,3) = rmse(signal, laf_recovery);
        
        figure;
        plot(laf_recovery);
        title('Linear Low-Pass Average Filter');
        laf_audio_sample = audioplayer(laf_recovery, fs);
        playblocking(laf_audio_sample);
        audiowrite('rayleigh_laf_',num2str(s),'.wav',laf_recovery,fs);
    
        % butterworth filter
        btw_recovery = buttfilt(noisy_signal,snr_actual_r(s));
        err_r(s,4) = rmse(signal, btw_recovery);
        
        figure;
        plot(btw_recovery);
        title('Butterworth Filter');
        btw_audio_sample = audioplayer(btw_recovery, fs);
        playblocking(btw_audio_sample);
        audiowrite('rayleigh_btw_',num2str(s),'.wav',btw_recovery,fs);
               
        % elliptical filter
        elp_recovery = ellipfilt(noisy_signal,fs);
        err_g(s,5) = rmse(signal, elp_recovery);

        figure;
        plot(elp_recovery);
        title('Elliptical Filter');
        elp_audio_sample = audioplayer(elp_recovery, fs);
        playblocking(elp_audio_sample);
        audiowrite('rayleigh_elp_',num2str(s),'.wav',elp_recovery,fs);
    end

    %% Traffic Noise
    snr_actual_t = zeros(2,3);
    err_t = zeros(1,5); % rows: snr | col: rmse

    % only one snr
    s = 1;
    [noisy_signal, snr_actual_t(s)] = addTrafficNoise(signal, fs);
    
    % FIGURE: noisy audio sample
    figure;
    plot(noisy_signal);
    title('Traffic Noise Audio Sample');
    noisy_audio_sample = audioplayer(noisy_signal, fs, 5);
    playblocking(noisy_audio_sample);
    audiowrite('traffic_noise_',num2str(s),'.wav',noisy_signal,fs);
    
    % Removing Noise
    % lowpass filter
    lpf_recovery = lowpass(noisy_signal, snr_actual_t(s));
    err_t(s,1) = rmse(signal, lpf_recovery);

    figure;
    plot(lpf_recovery);
    title('Lowpass Filter');
    lpf_audio_sample = audioplayer(lpf_recovery, fs);
    playblocking(lpf_audio_sample);
    audiowrite('traffic_lpf_',num2str(s),'.wav',lpf_recovery,fs);

    % bandstop filter
    bsf_recovery = bandstop(noisy_signal,snr_actual_t(s));
    err_t(s,2) = rmse(signal, bsf_recovery);

    figure;
    plot(bsf_recovery);
    title('Bandstop Filter');
    bsf_audio_sample = audioplayer(bsf_recovery, fs);
    playblocking(bsf_audio_sample);
    audiowrite('traffic_bsf_',num2str(s),'.wav',bsf_recovery,fs);

    % linear averaging filter
    laf_recovery = lpf_averaging(noisy_signal);
    err_t(s,3) = rmse(signal, laf_recovery);

    figure;
    plot(laf_recovery);
    title('Linear Low-Pass Average Filter');
    laf_audio_sample = audioplayer(laf_recovery, fs);
    playblocking(laf_audio_sample);
    audiowrite('traffic_laf_',num2str(s),'.wav',laf_recovery,fs);

    % butterworth filter
    btw_recovery = buttfilt(noisy_signal,snr_actual_t(s));
    err_t(s,4) = rmse(signal, btw_recovery);
    
    figure;
    plot(btw_recovery);
    title('Butterworth Filter');
    btw_audio_sample = audioplayer(btw_recovery, fs);
    playblocking(btw_audio_sample);
    audiowrite('traffic_btw_',num2str(s),'.wav',btw_recovery,fs);
           
    % elliptical filter
    elp_recovery = ellipfilt(noisy_signal,fs);
    err_g(s,5) = rmse(signal, elp_recovery);

    figure;
    plot(elp_recovery);
    title('Elliptical Filter');
    elp_audio_sample = audioplayer(elp_recovery, fs);
    playblocking(elp_audio_sample);
    audiowrite('traffic_elp_',num2str(s),'.wav',elp_recovery,fs);

    %% Background Conversation Noise
    snr_actual_b = zeros(1,3);
    err_b = zeros(1,5); % rows: snr | col: rmse
   
    % only one snr
    s = 1;
    [noisy_signal, snr_actual_b(s)] = addConversationNoise(signal, fs);

    % FIGURE: noisy audio sample
    figure;
    plot(noisy_signal);
    title('Background Conversation Noise Audio Sample');
    noisy_audio_sample = audioplayer(noisy_signal, fs);
    playblocking(noisy_audio_sample);
    audiowrite('conversation_noise_',num2str(s),'.wav',noisy_signal,fs);

    % Removing Noise
    % lowpass filter
    lpf_recovery = lowpass(noisy_signal, snr_actual_b(s));
    err_b(s,1) = rmse(signal, lpf_recovery);

    figure;
    plot(lpf_recovery);
    title('Lowpass Filter');
    lpf_audio_sample = audioplayer(lpf_recovery, fs);
    playblocking(lpf_audio_sample);
    audiowrite('conversation_lpf_',num2str(s),'.wav',lpf_recovery,fs);

    % bandstop filter
    bsf_recovery = bandstop(noisy_signal,snr_actual_b(s));
    err_b(s,2) = rmse(signal, bsf_recovery);

    figure;
    plot(bsf_recovery);
    title('Bandstop Filter');
    bsf_audio_sample = audioplayer(bsf_recovery, fs);
    playblocking(bsf_audio_sample);
    audiowrite('conversation_bsf_',num2str(s),'.wav',bsf_recovery,fs);

    % linear averaging filter
    laf_recovery = lpf_averaging(noisy_signal);
    err_b(s,3) = rmse(signal, laf_recovery);

    figure;
    plot(laf_recovery);
    title('Linear Low-Pass Average Filter');
    laf_audio_sample = audioplayer(laf_recovery, fs);
    playblocking(laf_audio_sample);
    audiowrite('conversation_laf_',num2str(s),'.wav',laf_recovery,fs);

    % butterworth filter
    btw_recovery = buttfilt(noisy_signal,snr_actual_b(s));
    err_b(s,4) = rmse(signal, btw_recovery);
     
    figure;
    plot(btw_recovery);
    title('Butterworth Filter');
    btw_audio_sample = audioplayer(btw_recovery, fs);
    playblocking(btw_audio_sample);
    audiowrite('conversation_btw_',num2str(s),'.wav',btw_recovery,fs);
           
    % elliptical filter
    elp_recovery = ellipfilt(noisy_signal,fs);
    err_g(s,5) = rmse(signal, elp_recovery);

    figure;
    plot(elp_recovery);
    title('Elliptical Filter');
    elp_audio_sample = audioplayer(elp_recovery, fs);
    playblocking(elp_audio_sample);
    audiowrite('econversation_elp_',num2str(s),'.wav',elp_recovery,fs);
end