function w=LDA(data)
%线性判别分析
%w返回的是超平面的参数
data_1=[];data_2=[];
for i=1:size(data,1)
    if data(i,end)==1
        data_1=[data_1;data(i,1:end-1)];   %类别1的矩阵
    else
        data_2=[data_2;data(i,1:end-1)];   %类别2的矩阵
    end
end
u1=sum(data_1,1)/size(data_1,1);    %均值
u2=sum(data_2,1)/size(data_2,1);
S_w=0;
for i=1:size(data_1,1)    %计算S_w
   S_w=S_w+(data_1(i,:)-u1)*(data_1(i,:)-u1)';
end
for i=1:size(data_2,1)
    S_w=S_w+(data_2(i,:)-u2)*(data_2(i,:)-u2)';
end
w=inv(S_w)*(u1-u2);
end