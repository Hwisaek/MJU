fs=8000
t=0:1/fs:1
X=sin(2*pi*t);

% 8��Ʈ ����ȭ
N=8; % N ��Ʈ ����ȭ
M=2^N; % N��Ʈ = M = 2^N��, N=4, M=16
Xmax = max(X) %��ȣ�� �ִ�ġ ex)10
stepsize = (2*Xmax)/M; % 1�ܰ�� ũ�� ex)20/16 = 1.25
for i = 1:M % i�� 1���� M����
    quantlevel(i) = -Xmax+stepsize*(i-0.5); %quantlevel(1)= -10+ 1.25*0.5 = -9.375
end
for j = 1:length(X)
    for i = 1:M
        if(X(j) >= quantlevel(i)-stepsize/2)&&(X(j) <= quantlevel(i) + stepsize/2)
            quant8X(j) = quantlevel(i); %������ �����Ͱ� �ش� ������ ������ ���ԵǴ°�� �׷����� ����ȭ��
        end
    end
end

% 7��Ʈ ����ȭ
N=7; % N ��Ʈ ����ȭ
M=2^N; % N��Ʈ = M = 2^N��, N=4, M=16
Xmax = max(X) %��ȣ�� �ִ�ġ ex)10
stepsize = (2*Xmax)/M; % 1�ܰ�� ũ�� ex)20/16 = 1.25
for i = 1:M % i�� 1���� M����
    quantlevel(i) = -Xmax+stepsize*(i-0.5); %quantlevel(1)= -10+ 1.25*0.5 = -9.375
end
for j = 1:length(X)
    for i = 1:M
        if(X(j) >= quantlevel(i)-stepsize/2)&&(X(j) <= quantlevel(i) + stepsize/2)
            quant7X(j) = quantlevel(i); %������ �����Ͱ� �ش� ������ ������ ���ԵǴ°�� �׷����� ����ȭ��
        end
    end
end

% 6��Ʈ ����ȭ
N=6; % N ��Ʈ ����ȭ
M=2^N; % N��Ʈ = M = 2^N��, N=4, M=16
Xmax = max(X) %��ȣ�� �ִ�ġ ex)10
stepsize = (2*Xmax)/M; % 1�ܰ�� ũ�� ex)20/16 = 1.25
for i = 1:M % i�� 1���� M����
    quantlevel(i) = -Xmax+stepsize*(i-0.5); %quantlevel(1)= -10+ 1.25*0.5 = -9.375
end
for j = 1:length(X)
    for i = 1:M
        if(X(j) >= quantlevel(i)-stepsize/2)&&(X(j) <= quantlevel(i) + stepsize/2)
            quant6X(j) = quantlevel(i); %������ �����Ͱ� �ش� ������ ������ ���ԵǴ°�� �׷����� ����ȭ��
        end
    end
end

% 5��Ʈ ����ȭ
N=5; % N ��Ʈ ����ȭ
M=2^N; % N��Ʈ = M = 2^N��, N=4, M=16
Xmax = max(X) %��ȣ�� �ִ�ġ ex)10
stepsize = (2*Xmax)/M; % 1�ܰ�� ũ�� ex)20/16 = 1.25
for i = 1:M % i�� 1���� M����
    quantlevel(i) = -Xmax+stepsize*(i-0.5); %quantlevel(1)= -10+ 1.25*0.5 = -9.375
end
for j = 1:length(X)
    for i = 1:M
        if(X(j) >= quantlevel(i)-stepsize/2)&&(X(j) <= quantlevel(i) + stepsize/2)
            quant5X(j) = quantlevel(i); %������ �����Ͱ� �ش� ������ ������ ���ԵǴ°�� �׷����� ����ȭ��
        end
    end
end

% 4��Ʈ ����ȭ
N=4; % N ��Ʈ ����ȭ
M=2^N; % N��Ʈ = M = 2^N��, N=4, M=16
Xmax = max(X) %��ȣ�� �ִ�ġ ex)10
stepsize = (2*Xmax)/M; % 1�ܰ�� ũ�� ex)20/16 = 1.25
for i = 1:M % i�� 1���� M����
    quantlevel(i) = -Xmax+stepsize*(i-0.5); %quantlevel(1)= -10+ 1.25*0.5 = -9.375
end
for j = 1:length(X)
    for i = 1:M
        if(X(j) >= quantlevel(i)-stepsize/2)&&(X(j) <= quantlevel(i) + stepsize/2)
            quant4X(j) = quantlevel(i); %������ �����Ͱ� �ش� ������ ������ ���ԵǴ°�� �׷����� ����ȭ��
        end
    end
end

% 3��Ʈ ����ȭ
N=3; % N ��Ʈ ����ȭ
M=2^N; % N��Ʈ = M = 2^N��, N=4, M=16
Xmax = max(X) %��ȣ�� �ִ�ġ ex)10
stepsize = (2*Xmax)/M; % 1�ܰ�� ũ�� ex)20/16 = 1.25
for i = 1:M % i�� 1���� M����
    quantlevel(i) = -Xmax+stepsize*(i-0.5); %quantlevel(1)= -10+ 1.25*0.5 = -9.375
end
for j = 1:length(X)
    for i = 1:M
        if(X(j) >= quantlevel(i)-stepsize/2)&&(X(j) <= quantlevel(i) + stepsize/2)
            quant3X(j) = quantlevel(i); %������ �����Ͱ� �ش� ������ ������ ���ԵǴ°�� �׷����� ����ȭ��
        end
    end
end

% 2��Ʈ ����ȭ
N=2; % N ��Ʈ ����ȭ
M=2^N; % N��Ʈ = M = 2^N��, N=4, M=16
Xmax = max(X) %��ȣ�� �ִ�ġ ex)10
stepsize = (2*Xmax)/M; % 1�ܰ�� ũ�� ex)20/16 = 1.25
for i = 1:M % i�� 1���� M����
    quantlevel(i) = -Xmax+stepsize*(i-0.5); %quantlevel(1)= -10+ 1.25*0.5 = -9.375
end
for j = 1:length(X)
    for i = 1:M
        if(X(j) >= quantlevel(i)-stepsize/2)&&(X(j) <= quantlevel(i) + stepsize/2)
            quant2X(j) = quantlevel(i); %������ �����Ͱ� �ش� ������ ������ ���ԵǴ°�� �׷����� ����ȭ��
        end
    end
end

% 1��Ʈ ����ȭ
N=1; % N ��Ʈ ����ȭ
M=2^N; % N��Ʈ = M = 2^N��, N=4, M=16
Xmax = max(X) %��ȣ�� �ִ�ġ ex)10
stepsize = (2*Xmax)/M; % 1�ܰ�� ũ�� ex)20/16 = 1.25
for i = 1:M % i�� 1���� M����
    quantlevel(i) = -Xmax+stepsize*(i-0.5); %quantlevel(1)= -10+ 1.25*0.5 = -9.375
end
for j = 1:length(X)
    for i = 1:M
        if(X(j) >= quantlevel(i)-stepsize/2)&&(X(j) <= quantlevel(i) + stepsize/2)
            quant1X(j) = quantlevel(i); %������ �����Ͱ� �ش� ������ ������ ���ԵǴ°�� �׷����� ����ȭ��
        end
    end
end

plot(t,X,t,quant4X),grid on;
legend('Orginal','Quantization')
xlabel('Time');
ylabel('amplitude');