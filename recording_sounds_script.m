load handel.mat

recObj = audiorecorder

disp('Start speaking.')
recordblocking(recObj, 5);
disp('End of Recording.');

play(recObj);