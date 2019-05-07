clc,clear
data=importdata('F:\machinelearninginaction-master\Ch10\testSet.txt');
for i=1:length(data)
    plot(data(i,1),data(i,2),'o')
    hold on
end
%����������Ҫѡ��k�Ĵ�С
k=randperm(10,1)   %���������
%��ô������������ѡ��k��������
%sum=zeros(k,2);   %��������ı���
random=randperm(length(data),k)
%������
u=zeros(k,2);
u1=zeros(k,2);
for i=1:k
    u(i,1)=data(random(i),1);
    u(i,2)=data(random(i),2);
end
while 1
    count=zeros(k,2);
    count1=zeros(k,2);
    sum=zeros(k,2);
    for i=1:length(data)
        for j=1:k
            distance(i,j)=(data(i,1)-u(j,1))^2+(data(i,2)-u(j,2))^2;
        end
        %�ҵ�ÿ��distance��С��,�������������ĸ����
        [dd(i),I(i)]=min(distance(i,:));
        for y=1:k
            if I(i)==y
                sum(y,1)=sum(y,1)+data(i,1);
                sum(y,2)=sum(y,2)+data(i,2);
                count(y,1)=count(y,1)+1;
                count(y,2)=count(y,2)+1;
            end
        end      
    end
    u=sum./count;         %����������
    if abs(u-u1)<0.1 %�����������ڸı��ʱ�������������� 
        break;
    end
    u1=u;
    count1=count;
end

for i=1:length(u)
    plot(u1(i,1),u1(i,2),'r+');
    hold on
end