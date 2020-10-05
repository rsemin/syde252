load handel.mat

filename = 'C:\Users\romas\Downloads\test_audio.wav';

% read audio
audiowrite(filename,y,Fs);

% play the audio
% sound(y,Fs)

% information about audio file
info = audioinfo(filename)

t = 0:seconds(1/Fs):seconds(info.Duration);
t = t(1:end-1);

plot(t,y)
xlabel('Time')
ylabel('Audio Signal')

clear y Fs