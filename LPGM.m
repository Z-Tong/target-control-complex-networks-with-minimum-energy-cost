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

v=0.05; %��������
ot=0.025; %����ʱ�䲽
iterations=1;  %�ܵ�ѭ������
Iterations_number=300; 
tf = 1;


I_N=eye(N);
C_N=randperm(N);
S=30;
CC_N=C_N(1,1:S);
 
C=I_N(CC_N,:);%%Target control matrix%%Target control matrix

Cost11=zeros(N,M);
for ii=1:iterations
    
    B=randn(N,M); %BΪ����Ȩ�ؾ��������ʼֵ
    WB0=zeros(N,N); 
    F0=zeros(N,M);
    Xf=expm(A*tf)*expm(A'*tf); %�Ծ�����ָ������ÿ��Ԫ����ָ��
    
    Cost=zeros(Iterations_number,1);
    Cost3=zeros(Iterations_number,1);
    
    cost_best=9000000000000000;
    ZZ=[]
    %1200���ݶ��½�����
    for k=1:Iterations_number
       % fprintf('No. %d Epoch, No. %d Descent \n',ii,k);
        Bc=abs(B); 
        B0=B_binary(Bc,m0);
        WB0=zeros(N,N);
        F0=zeros(N,M);
        %����������е�WB����Ϊ�����WB0
        for k1=1:tf/ot
            WB0 = WB0+expm(A*(ot*k1))*B0*B0'*expm(A'*(ot*k1))*ot;
        end
        D = pinv(C*WB0*C');
        
        Cost(k)=trace(C'*D*C*Xf);
        Cost3(k)=trace(B'*B);
        
        %����������е�����������B������ݶȡ�
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
%���������logͼ
figure(1)
plot(ZZ,'r-*','LineWidth',1.5)
xlabel('Number of Iterations','fontsize',15);
    ylabel('Cost','fontsize',15);
   set(gca,'linewidth',2);
set(gca,'FontName','Times New Roman','FontSize',16) 









