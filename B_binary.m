function [ Bb ] = B_binary( B,m0 )
%��B����Ϊbinary����
%B��ά��ΪN*M��NΪ�ڵ����������ʱ��M+m0������ȥѡ��M������1������Ϊ0
%����BbΪֻ��1��0�Ŀ��ƾ���
[N,M]=size(B);

if M+m0>N
    fprintf('B��ֵ��������m0ȡֵ̫��')
else
    
    sum_B=sum(abs(B),2);
    [max_v order]=sort(sum_B);%max_vΪֵ��orderΪ��sum_B�е����
    %P����ΪM+m0��Ȩ������Ĳ�����������,��1��Ϊ�������ʣ���2�д洢�����0-N-1
    P = zeros(M+m0,2);
    for k=1:M+m0
        P(k,1) = max_v(end-k+1);
        P(k,2) = order(end-k+1);
    end
    P(:,1) = P(:,1)./sum(P(:,1)); %��Ȩ��ֵת��Ϊ��������
    
    
    counter = 0; %��¼�Լ������˶��ٸ���
    control_node_index = []; %���Ƶ�����
    while counter<M
        m = size(P,1); %P������еĵ�᲻��ɾ������˳��Ȼ�䣬ʵ���ϵ��䳤��Ϊm0ʱ��counterҲ��ΪM����������
        for i=1:m
            sample = 0;
            if rand<=P(i,1)
                sample = 1;
            end
            if sample==1 %���������
                control_node_index = [control_node_index P(i,2)];
                P(i,:) = []; %Pɾ��һ��
                P(:,1) = P(:,1)./sum(P(:,1)); %��Ȩ��ֵ���¹�һ��ת��Ϊ��������
                counter = counter + 1;
                break; %������ǰѭ��
            end
        end
    end
    Bb = zeros(N,M);
    if length(control_node_index)~=M
        fprintf('���������ĵ�����ΪM��')
    else
        for k=1:M
            Bb(control_node_index(k),k)=1;
        end
    end
end

%Bb = B;

end

