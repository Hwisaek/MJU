[sample8000,fs] = audioread('SR_8000.wav');
t=1:length(sample8000);
N=2; % N ��Ʈ ����ȭ
M=2^N; % N��Ʈ = M = 2^N��, N=4, M=16
Xmax = max(sample8000) %��ȣ�� �ִ�ġ ex)10
stepsize = (2*Xmax)/M; % 1�ܰ�� ũ�� ex)20/16 = 1.25

for i = 1:M % i�� 1���� M����
    quantlevel(i) = -Xmax+stepsize*(i-0.5); %quantlevel(1)= -10+ 1.25*0.5 = -9.375
end
for j = 1:length(sample8000)
    for i = 1:M
        if(sample8000(j) >= quantlevel(i)-stepsize/2)&&(sample8000(j) <= quantlevel(i) + stepsize/2)
            quantX(j) = quantlevel(i); %������ �����Ͱ� �ش� ������ ������ ���ԵǴ°�� �׷����� ����ȭ��
        end
    end
end

plot(t,sample8000,t,quantX),grid on;
legend('Orginal','quant')
title('��');
xlabel('Time');
ylabel('amplitude');

