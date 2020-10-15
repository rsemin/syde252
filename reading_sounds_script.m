load handel.mat
audiofile = 'C:\Users\romas\Downloads\test_audio.wav';


%% 3.1 Reading function

[y,Fs] = audioread(audiofile);

%check sample rate and resample if needed (3.6)
if Fs ~= 16000
    resample_signal(y,Fs);
end 

%{
[rows, columns] = size(y)
new_column = rand(rows,1);
y = [y new_column]
%}

%% 3.2 Convert to Mono 
y = convert_to_mono(y);

%% 3.3 Play the Sound
%sound(y,Fs);

%% 3.4 Write to a New File
new_filename = 'New_Sound_File.wav';
audiowrite(new_filename,y,Fs);

%% 3.5 Plot the Signal
plot_signal(y);

%% 3.6 

%% 3.7 Cosine function
signal_info = audioinfo(audiofile);
generate_and_plot_cosine_signal(y,Fs,signal_info);

%% Functions

function [y] = convert_to_mono(y)
    [rows, columns] = size(y);
    
    % combine the columns for stereo (2 column sound)
    if columns == 2
        merged_column = y(:,1) + y(:,2);
        y(:,1) = [];
        y(:,1) = [];
        y = [merged_column];
    end 
end

function [] = plot_signal(y)
    plot(1:length(y), y);
end 

function [] = resample_signal(y,Fs)
    %https://www.mathworks.com/help/signal/ug/changing-signal-sample-rate.html
    %https://www.mathworks.com/help/signal/ref/resample.html#bumhz33-x
    Fs_new = 16000;
    [P,Q] = rat(Fs_new/Fs);
    disp(class(P));
    disp(class(Q));
    abs(P/Q*Fs-16000) %gives us percision (closer to 0 the better)
    
    %y_new = resample(y,P,Q);
    %y_new = resample(y,Fs,Fs_new);
    
end

function [] = generate_and_plot_cosine_signal(y,Fs,info)
    %https://www.mathworks.com/matlabcentral/answers/69293-how-do-create-a-message-signal-m-t-cos-2-fmt-fm-5-khz-and-plot-the-signal-both-in-time-domai
   dt = 1/Fs;
   t =  (0:dt:info.Duration)'; % configure duration (= array length)
   Fm = 5000; % what is thiiiiiis???
   y = cos(2*pi*Fm*t);
   
   % plot
   figure;
   idx = (t>=0 & t <=0.002-dt) ;
   
   hold on
   plot(t(idx),y(idx));
end

%{
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
%}
%%

