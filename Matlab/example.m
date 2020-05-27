[sample8000,fs] = audioread('SR_8000.wav');
t=1:length(sample8000);
N=2; % N 비트 양자화
M=2^N; % N비트 = M = 2^N승, N=4, M=16
Xmax = max(sample8000) %신호의 최대치 ex)10
stepsize = (2*Xmax)/M; % 1단계당 크기 ex)20/16 = 1.25

for i = 1:M % i는 1부터 M까지
    quantlevel(i) = -Xmax+stepsize*(i-0.5); %quantlevel(1)= -10+ 1.25*0.5 = -9.375
end
for j = 1:length(sample8000)
    for i = 1:M
        if(sample8000(j) >= quantlevel(i)-stepsize/2)&&(sample8000(j) <= quantlevel(i) + stepsize/2)
            quantX(j) = quantlevel(i); %샘플의 데이터가 해당 레벨의 범위에 포함되는경우 그레벨로 양자화함
        end
    end
end

plot(t,sample8000,t,quantX),grid on;
legend('Orginal','quant')
title('비교');
xlabel('Time');
ylabel('amplitude');

