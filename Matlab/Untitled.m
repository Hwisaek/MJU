fs=8000
t=0:1/fs:1
X=sin(2*pi*t);

% 8비트 양자화
N=8; % N 비트 양자화
M=2^N; % N비트 = M = 2^N승, N=4, M=16
Xmax = max(X) %신호의 최대치 ex)10
stepsize = (2*Xmax)/M; % 1단계당 크기 ex)20/16 = 1.25
for i = 1:M % i는 1부터 M까지
    quantlevel(i) = -Xmax+stepsize*(i-0.5); %quantlevel(1)= -10+ 1.25*0.5 = -9.375
end
for j = 1:length(X)
    for i = 1:M
        if(X(j) >= quantlevel(i)-stepsize/2)&&(X(j) <= quantlevel(i) + stepsize/2)
            quant8X(j) = quantlevel(i); %샘플의 데이터가 해당 레벨의 범위에 포함되는경우 그레벨로 양자화함
        end
    end
end

% 7비트 양자화
N=7; % N 비트 양자화
M=2^N; % N비트 = M = 2^N승, N=4, M=16
Xmax = max(X) %신호의 최대치 ex)10
stepsize = (2*Xmax)/M; % 1단계당 크기 ex)20/16 = 1.25
for i = 1:M % i는 1부터 M까지
    quantlevel(i) = -Xmax+stepsize*(i-0.5); %quantlevel(1)= -10+ 1.25*0.5 = -9.375
end
for j = 1:length(X)
    for i = 1:M
        if(X(j) >= quantlevel(i)-stepsize/2)&&(X(j) <= quantlevel(i) + stepsize/2)
            quant7X(j) = quantlevel(i); %샘플의 데이터가 해당 레벨의 범위에 포함되는경우 그레벨로 양자화함
        end
    end
end

% 6비트 양자화
N=6; % N 비트 양자화
M=2^N; % N비트 = M = 2^N승, N=4, M=16
Xmax = max(X) %신호의 최대치 ex)10
stepsize = (2*Xmax)/M; % 1단계당 크기 ex)20/16 = 1.25
for i = 1:M % i는 1부터 M까지
    quantlevel(i) = -Xmax+stepsize*(i-0.5); %quantlevel(1)= -10+ 1.25*0.5 = -9.375
end
for j = 1:length(X)
    for i = 1:M
        if(X(j) >= quantlevel(i)-stepsize/2)&&(X(j) <= quantlevel(i) + stepsize/2)
            quant6X(j) = quantlevel(i); %샘플의 데이터가 해당 레벨의 범위에 포함되는경우 그레벨로 양자화함
        end
    end
end

% 5비트 양자화
N=5; % N 비트 양자화
M=2^N; % N비트 = M = 2^N승, N=4, M=16
Xmax = max(X) %신호의 최대치 ex)10
stepsize = (2*Xmax)/M; % 1단계당 크기 ex)20/16 = 1.25
for i = 1:M % i는 1부터 M까지
    quantlevel(i) = -Xmax+stepsize*(i-0.5); %quantlevel(1)= -10+ 1.25*0.5 = -9.375
end
for j = 1:length(X)
    for i = 1:M
        if(X(j) >= quantlevel(i)-stepsize/2)&&(X(j) <= quantlevel(i) + stepsize/2)
            quant5X(j) = quantlevel(i); %샘플의 데이터가 해당 레벨의 범위에 포함되는경우 그레벨로 양자화함
        end
    end
end

% 4비트 양자화
N=4; % N 비트 양자화
M=2^N; % N비트 = M = 2^N승, N=4, M=16
Xmax = max(X) %신호의 최대치 ex)10
stepsize = (2*Xmax)/M; % 1단계당 크기 ex)20/16 = 1.25
for i = 1:M % i는 1부터 M까지
    quantlevel(i) = -Xmax+stepsize*(i-0.5); %quantlevel(1)= -10+ 1.25*0.5 = -9.375
end
for j = 1:length(X)
    for i = 1:M
        if(X(j) >= quantlevel(i)-stepsize/2)&&(X(j) <= quantlevel(i) + stepsize/2)
            quant4X(j) = quantlevel(i); %샘플의 데이터가 해당 레벨의 범위에 포함되는경우 그레벨로 양자화함
        end
    end
end

% 3비트 양자화
N=3; % N 비트 양자화
M=2^N; % N비트 = M = 2^N승, N=4, M=16
Xmax = max(X) %신호의 최대치 ex)10
stepsize = (2*Xmax)/M; % 1단계당 크기 ex)20/16 = 1.25
for i = 1:M % i는 1부터 M까지
    quantlevel(i) = -Xmax+stepsize*(i-0.5); %quantlevel(1)= -10+ 1.25*0.5 = -9.375
end
for j = 1:length(X)
    for i = 1:M
        if(X(j) >= quantlevel(i)-stepsize/2)&&(X(j) <= quantlevel(i) + stepsize/2)
            quant3X(j) = quantlevel(i); %샘플의 데이터가 해당 레벨의 범위에 포함되는경우 그레벨로 양자화함
        end
    end
end

% 2비트 양자화
N=2; % N 비트 양자화
M=2^N; % N비트 = M = 2^N승, N=4, M=16
Xmax = max(X) %신호의 최대치 ex)10
stepsize = (2*Xmax)/M; % 1단계당 크기 ex)20/16 = 1.25
for i = 1:M % i는 1부터 M까지
    quantlevel(i) = -Xmax+stepsize*(i-0.5); %quantlevel(1)= -10+ 1.25*0.5 = -9.375
end
for j = 1:length(X)
    for i = 1:M
        if(X(j) >= quantlevel(i)-stepsize/2)&&(X(j) <= quantlevel(i) + stepsize/2)
            quant2X(j) = quantlevel(i); %샘플의 데이터가 해당 레벨의 범위에 포함되는경우 그레벨로 양자화함
        end
    end
end

% 1비트 양자화
N=1; % N 비트 양자화
M=2^N; % N비트 = M = 2^N승, N=4, M=16
Xmax = max(X) %신호의 최대치 ex)10
stepsize = (2*Xmax)/M; % 1단계당 크기 ex)20/16 = 1.25
for i = 1:M % i는 1부터 M까지
    quantlevel(i) = -Xmax+stepsize*(i-0.5); %quantlevel(1)= -10+ 1.25*0.5 = -9.375
end
for j = 1:length(X)
    for i = 1:M
        if(X(j) >= quantlevel(i)-stepsize/2)&&(X(j) <= quantlevel(i) + stepsize/2)
            quant1X(j) = quantlevel(i); %샘플의 데이터가 해당 레벨의 범위에 포함되는경우 그레벨로 양자화함
        end
    end
end

plot(t,X,t,quant4X),grid on;
legend('Orginal','Quantization')
xlabel('Time');
ylabel('amplitude');