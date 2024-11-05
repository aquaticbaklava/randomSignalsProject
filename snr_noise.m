function P_noise = snr_noise(SNR, signal, type)
%SNR_NOISE: find the noise power given the desired snr and signal
% SNR: in dB
% signal: clean signal (without noise)
% type: type of noise
% Gaussian: actual SNR close to ideal SNR
% Uniform: actual SNR ends up being around ~4.5dB higher

P_noise = std(signal) / db2mag(SNR);
% Gaussian Random Variable
if type == 'G'
    return;
end

% Uniform Random Variable
if type == 'U'
    P_noise = pow2db(P_noise) + 4.5/2;
    P_noise = db2pow(P_noise);
end

% Exponential Random Variable
if type == 'E'
    
end
% Rayleigh Random Varaible
if type == 'R'

end

end