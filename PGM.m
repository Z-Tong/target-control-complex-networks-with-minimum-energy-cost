clear all;
close all;
clc;
load cons_frequency_rev;
A=cons_frequency_rev; 
 A;
 N=length(A);
%A=[zeros(1,N-1)  1; eye(N-1) zeros(N-1,1)];
%A=ErSfNetGen(1,100,3);
%dataset_name = 'A100ER'
L=sum(sum(A));

N=size(A,1);
M=15;

v=0.05; %迭代步长
ot=0.025; %积分时间步
iterations=1;  %总的循环次数
Iterations_number=200; 
tf = 1;


I_N=eye(N);
C_N=randperm(N);
S=30;
CC_N=C_N(1,1:S);
 
C=I_N(CC_N,:);%%Target control matrix%%Target control matrix


Cost11=zeros(N,M);
for ii=1:iterations
    
    B=randn(N,M); %B为控制权重矩阵，随机初始值
    MM=M; %规定了一个norm值
    
    B=(sqrt(1*(MM+0.1)/trace(B'*B)))*B; %initiate the norm to MM-1

    M=min(size((B)));  %M这里一般情况下就是M
    WB0=zeros(N,N); 
    F0=zeros(N,M);
    Xf=expm(A*tf)*expm(A'*tf); %对矩阵求指数，非每个元素求指数
    
    Cost=zeros(Iterations_number,1);
    Cost3=zeros(Iterations_number,1);
    Cost5=zeros(Iterations_number,1);

    
    %1200次梯度下降迭代
    for k=1:Iterations_number
       % fprintf('No. %d Epoch, No. %d Descent \n',ii,k);
        
        WB0=zeros(N,N);
        F0=zeros(N,M);
        %先求出文章中的WB，即为这里的WB0
        for k1=1:tf/ot
            WB0 = WB0+expm(A*(ot*k1))*B*B'*expm(A'*(ot*k1))*ot;
        end
        D = pinv(C*WB0*C');
        
        Cost(k)=trace(C'*D*C*Xf);
        Cost3(k)=trace(B'*B);
        
        %再求出文章中的能量函数对B矩阵的梯度。
        for k1=1:tf/ot
            F0=F0-(expm(A'*(ot*k1))*C'*D*C*Xf*C'*D*C*expm(A*(ot*k1)))*B*ot;
        end
        F00=F0/norm(F0); 
          
        %F1为Norm函数对B的梯度
        F1=(1/ot)*(2*trace(B'*B)-2*MM)*2*B; % gradient of norm function
        F11=F1/norm(F1); %归一化Norm函数梯度
        F11=-(sqrt(1*(MM+0.001)/trace(F11'*F11)))*F11;    %Normailize gradient of norm function
        
         Cost5(k)=-sum(F00(:).*F11(:))/(norm(F00(:))*norm(F11(:)));
          B = B-v*F0/norm(F0);  % F0 is the projected direction
          B = sqrt(1*(MM+0.001)/trace(B'*B))*B; %initiate the norm to MM+1
       
    k
    end
    
end
Cost
%输出能量的log图
figure(1)
plot(log10(Cost),'r-*')

figure(2)
plot(Cost3,'r-*')
legend('trace BB')

figure(3)
plot(Cost5,'r-*')






