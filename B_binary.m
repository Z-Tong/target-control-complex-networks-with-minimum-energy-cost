function [ Bb ] = B_binary( B,m0 )
%将B采样为binary矩阵
%B的维度为N*M，N为节点个数，采样时从M+m0个点中去选择M个点置1，其余为0
%返回Bb为只有1和0的控制矩阵
[N,M]=size(B);

if M+m0>N
    fprintf('B二值化过程中m0取值太大！')
else
    
    sum_B=sum(abs(B),2);
    [max_v order]=sort(sum_B);%max_v为值，order为在sum_B中的序号
    %P矩阵为M+m0个权重最大点的采样概率向量,第1列为采样概率，第2列存储点序号0-N-1
    P = zeros(M+m0,2);
    for k=1:M+m0
        P(k,1) = max_v(end-k+1);
        P(k,2) = order(end-k+1);
    end
    P(:,1) = P(:,1)./sum(P(:,1)); %将权重值转换为采样概率
    
    
    counter = 0; %记录以及采样了多少个点
    control_node_index = []; %控制点的序号
    while counter<M
        m = size(P,1); %P矩阵采中的点会不断删除，因此长度会变，实际上当其长度为m0时，counter也会为M，采样结束
        for i=1:m
            sample = 0;
            if rand<=P(i,1)
                sample = 1;
            end
            if sample==1 %如果采中了
                control_node_index = [control_node_index P(i,2)];
                P(i,:) = []; %P删除一行
                P(:,1) = P(:,1)./sum(P(:,1)); %将权重值重新归一化转换为采样概率
                counter = counter + 1;
                break; %跳出当前循环
            end
        end
    end
    Bb = zeros(N,M);
    if length(control_node_index)~=M
        fprintf('采样出来的点数不为M！')
    else
        for k=1:M
            Bb(control_node_index(k),k)=1;
        end
    end
end

%Bb = B;

end

