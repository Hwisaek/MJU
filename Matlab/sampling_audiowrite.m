
fs=8000;
t=(1:length(sample8000))/fs;

subplot(4,1,1)
stem(t,sample8000),grid on;
legend('8000-Sample')
xlim([0.001 0.005])
ylim([-0.15 0.15])
xlabel('Time');
ylabel('amplitude');

for j = 1:length(sample8000)/2
    sample4000(j)=sample8000(2*j-1)
end

fs=4000;
t=(1:length(sample4000))/fs;


subplot(4,1,2)
stem(t,sample4000),grid on;
legend('4000-Sample')
xlim([0.001 0.005])
ylim([-0.15 0.15])
xlabel('Time');
ylabel('amplitude');

for j = 1:length(sample8000)/4
    sample2000(j)=sample8000(4*j-3)
end

fs=2000;
t=(1:length(sample2000))/fs;

subplot(4,1,3)
stem(t,sample2000),grid on;
legend('2000-Sample')
xlim([0.001 0.005])
ylim([-0.15 0.15])
xlabel('Time');
ylabel('amplitude');
for j = 1:length(sample8000)/8
    sample1000(j)=sample8000(8*j-7);
end


fs=1000;
t=(1:length(sample1000))/fs;

subplot(4,1,4)
stem(t,sample1000),grid on;
legend('1000-Sample')
xlim([0.001 0.005])
ylim([-0.15 0.15])
xlabel('Time');
ylabel('amplitude');

audiowrite('sampling_8000.wav',sample8000,8000)
audiowrite('sampling_4000.wav',sample4000,4000)
audiowrite('sampling_2000.wav',sample2000,2000)
audiowrite('sampling_1000.wav',sample1000,1000)