clear all;
close all;
clc;
load cons_frequency_rev;
A=cons_frequency_rev; 
 A;
 N=length(A);
%A=ErSfNetGen(1,100,3);
%dataset_name = 'A100ER'
L=sum(sum(A));

N=size(A,1);
M=15;
m0=5;

v=0.05; %迭代步长
ot=0.025; %积分时间步
iterations=1;  %总的循环次数
Iterations_number=300; 
tf = 1;


I_N=eye(N);
C_N=randperm(N);
S=30;
CC_N=C_N(1,1:S);
 
C=I_N(CC_N,:);%%Target control matrix%%Target control matrix

Cost11=zeros(N,M);
for ii=1:iterations
    
    B=randn(N,M); %B为控制权重矩阵，随机初始值
    WB0=zeros(N,N); 
    F0=zeros(N,M);
    Xf=expm(A*tf)*expm(A'*tf); %对矩阵求指数，非每个元素求指数
    
    Cost=zeros(Iterations_number,1);
    Cost3=zeros(Iterations_number,1);
    
    cost_best=9000000000000000;
    ZZ=[]
    %1200次梯度下降迭代
    for k=1:Iterations_number
       % fprintf('No. %d Epoch, No. %d Descent \n',ii,k);
        Bc=abs(B); 
        B0=B_binary(Bc,m0);
        WB0=zeros(N,N);
        F0=zeros(N,M);
        %先求出文章中的WB，即为这里的WB0
        for k1=1:tf/ot
            WB0 = WB0+expm(A*(ot*k1))*B0*B0'*expm(A'*(ot*k1))*ot;
        end
        D = pinv(C*WB0*C');
        
        Cost(k)=trace(C'*D*C*Xf);
        Cost3(k)=trace(B'*B);
        
        %再求出文章中的能量函数对B矩阵的梯度。
        for k1=1:tf/ot
            F0=F0-(expm(A'*(ot*k1))*C'*D*C*Xf*C'*D*C*expm(A*(ot*k1)))*B*ot;
        end
        F00=F0/norm(F0); 
   
         if (Cost(k)<cost_best)
         cost_best=Cost(k);
         B=B0;
         B_best=B0;
         B=B_best-v*F00;
         else
         B=B0-v*F00;
         end
    ZZ=[ZZ cost_best];
   k
    end
    
end
cost_best
ZZ
%输出能量的log图
figure(1)
plot(ZZ,'r-*','LineWidth',1.5)
xlabel('Number of Iterations','fontsize',15);
    ylabel('Cost','fontsize',15);
   set(gca,'linewidth',2);
set(gca,'FontName','Times New Roman','FontSize',16) 









