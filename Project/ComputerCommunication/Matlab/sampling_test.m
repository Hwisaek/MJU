
subplot(4,1,1)
stairs(t,sample8000),grid on;
legend('8000-Sample')
xlim([1/fs 0.01])
ylim([-0.15 0.15])
xlabel('Time');
ylabel('amplitude');

for j = 1:length(sample8000)/2
    sample4000(2*j)=sample8000(2*j-1)
    sample4000(2*j-1)=sample8000(2*j-1)
end
sample4000(801)=sample8000(801)

subplot(4,1,2)
stairs(t,sample4000),grid on;
legend('4000-Sample')
xlim([1/fs 0.01])
ylim([-0.15 0.15])
xlabel('Time');
ylabel('amplitude');

for j = 1:length(sample8000)/4
    sample2000(4*j)=sample8000(4*j-3)
    sample2000(4*j-1)=sample8000(4*j-3)
    sample2000(4*j-2)=sample8000(4*j-3)
    sample2000(4*j-3)=sample8000(4*j-3)
end
sample2000(801)=sample8000(801)

subplot(4,1,3)
stairs(t,sample2000),grid on;
legend('2000-Sample')
xlim([1/fs 0.01])
ylim([-0.15 0.15])
xlabel('Time');
ylabel('amplitude');
for j = 1:length(sample8000)/8
    sample1000(8*j)=sample8000(8*j-7);
    sample1000(8*j-1)=sample8000(8*j-7);
    sample1000(8*j-2)=sample8000(8*j-7);
    sample1000(8*j-3)=sample8000(8*j-7);
    sample1000(8*j-4)=sample8000(8*j-7);
    sample1000(8*j-5)=sample8000(8*j-7);
    sample1000(8*j-6)=sample8000(8*j-7);
    sample1000(8*j-7)=sample8000(8*j-7);
end
sample1000(801)=sample8000(801)

subplot(4,1,4)
stairs(t,sample1000),grid on;
legend('1000-Sample')
xlim([1/fs 0.01])
ylim([-0.15 0.15])
xlabel('Time');
ylabel('amplitude');
