% ECE 5523: Random Signals - Final Project
% Function to Play Signal
%
function playSignal(Signal, fs, SignalType)
    disp(['Playing ' SignalType ' WAV file...']);
    sound(Signal, fs);

    % Wait until the audio finishes playing
    pause(length(Signal)/fs + 1); 
end