function w=LDA(data)
%�����б����
%w���ص��ǳ�ƽ��Ĳ���
data_1=[];data_2=[];
for i=1:size(data,1)
    if data(i,end)==1
        data_1=[data_1;data(i,1:end-1)];   %���1�ľ���
    else
        data_2=[data_2;data(i,1:end-1)];   %���2�ľ���
    end
end
u1=sum(data_1,1)/size(data_1,1);    %��ֵ
u2=sum(data_2,1)/size(data_2,1);
S_w=0;
for i=1:size(data_1,1)    %����S_w
   S_w=S_w+(data_1(i,:)-u1)*(data_1(i,:)-u1)';
end
for i=1:size(data_2,1)
    S_w=S_w+(data_2(i,:)-u2)*(data_2(i,:)-u2)';
end
w=inv(S_w)*(u1-u2);
end