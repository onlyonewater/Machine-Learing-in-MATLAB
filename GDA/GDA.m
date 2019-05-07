clc,clear
%GDA�㷨 ��˹�б��㷨
data_x=importdata('q4_x.txt');
data_y=importdata('q4_y.txt');
label=zeros(length(data_y),1);    %y�ı�ǩ
for i=1:length(data_y)
    if strcmp(data_y{i},'����˹����')==1
        label(i)=0;
        plot(data_x(i,1),data_x(i,2),'*');
        hold on
    else
        label(i)=1;
        plot(data_x(i,1),data_x(i,2),'o');
        hold on
    end
end
total_data=[data_x,label];
%������֤
cv=cvpartition(length(total_data),'holdout',0.1);
train_data=total_data(training(cv),:);
test_data=total_data(test(cv),:);
%��train_data����GDA���������
%fiv�����
fiv=length(find(train_data(:,3)==1))/length(train_data);
%�ֱ����������˹�ֲ��ľ�ֵ
u01=sum(train_data(find(train_data(:,3)==0),1))/length(find(train_data(:,3)==0))
u02=sum(train_data(find(train_data(:,3)==0),2))/length(find(train_data(:,3)==0))
u11=sum(train_data(find(train_data(:,3)==1),1))/length(find(train_data(:,3)==1))
u12=sum(train_data(find(train_data(:,3)==1),2))/length(find(train_data(:,3)==1))
%��ô����0�ľ�ֵ
u0=[u01,u02]
%����1�ľ�ֵ
u1=[u11,u12]
%����Э���������Ϊ�����Э�����ǲ�һ����
%���ھ���Ĵ�С��һ��������������Ҫ��u0���������չ
u0u0=repmat(u0,length(find(train_data(:,3)==0)),1)
cigma0=(train_data(find(train_data(:,3)==0),1:2)-u0u0)'*(train_data(find(train_data(:,3)==0),1:2)-u0u0)/length(find(train_data(:,3)==0))
%��u1���������չ
u1u1=repmat(u1,length(find(train_data(:,3)==1)),1)
cigma1=(train_data(find(train_data(:,3)==1),1:2)-u1u1)'*(train_data(find(train_data(:,3)==1),1:2)-u1u1)/length(find(train_data(:,3)==1))
%�����������⣬���ǵó��˸�˹�ֲ��Ĳ����Ͳ�Ŭ���ֲ��Ĳ���
%�������ǰ�������˹�ֲ��ĵȸ��߻�����
x0=40:1:180;
y0=300:1:550;
[X0,Y0]=meshgrid(x0,y0);
X=[X0(:) Y0(:)];
z0=mvnpdf(X,u0,cigma0);    %��Ԫ��˹�ֲ�����
hold on
contour(X0,Y0,reshape(z0,length(y0),length(x0)))
z1=mvnpdf(X,u1,cigma1); 
contour(X0,Y0,reshape(z1,length(y0),length(x0)))
%�������10��������ж�
for i=1:length(test_data)
    zz0=mvnpdf(test_data(i,1:2),u0,cigma0);
    result0=zz0*(1-fiv);
    zz1=mvnpdf(test_data(i,1:2),u1,cigma1);
    result1=zz1*fiv;
    if result0>result1
        disp('���ڰ�����˹��')
    else
        disp('���ڼ��ô�')
    end
end