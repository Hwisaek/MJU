sampling_8000 = audiorecorder(8000,8,1,1); % 객체설정 8000샘플, 8비트, 모노
sampling_4000 = audiorecorder(4000,8,1,1);
sampling_2000 = audiorecorder(2000,8,1,1);
sampling_1000 = audiorecorder(1000,8,1,1);
disp('Start speaking.');
record(sampling_8000);
record(sampling_4000);
record(sampling_2000);
record(sampling_1000);
pause(5);
stop(sampling_8000);
stop(sampling_4000);
stop(sampling_2000);
stop(sampling_1000);
disp('End of Recording.');
play(sampling_8000); % 재생



