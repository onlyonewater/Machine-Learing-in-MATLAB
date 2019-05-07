clc,clear
%GDA算法 高斯判别算法
data_x=importdata('q4_x.txt');
data_y=importdata('q4_y.txt');
label=zeros(length(data_y),1);    %y的标签
for i=1:length(data_y)
    if strcmp(data_y{i},'阿拉斯加州')==1
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
%交叉验证
cv=cvpartition(length(total_data),'holdout',0.1);
train_data=total_data(training(cv),:);
test_data=total_data(test(cv),:);
%对train_data进行GDA参数的求解
%fiv的求解
fiv=length(find(train_data(:,3)==1))/length(train_data);
%分别计算两个高斯分布的均值
u01=sum(train_data(find(train_data(:,3)==0),1))/length(find(train_data(:,3)==0))
u02=sum(train_data(find(train_data(:,3)==0),2))/length(find(train_data(:,3)==0))
u11=sum(train_data(find(train_data(:,3)==1),1))/length(find(train_data(:,3)==1))
u12=sum(train_data(find(train_data(:,3)==1),2))/length(find(train_data(:,3)==1))
%那么数据0的均值
u0=[u01,u02]
%数据1的均值
u1=[u11,u12]
%计算协方差，我们认为这儿的协方差是不一样的
%由于矩阵的大小不一样，所以我们需要对u0矩阵进行扩展
u0u0=repmat(u0,length(find(train_data(:,3)==0)),1)
cigma0=(train_data(find(train_data(:,3)==0),1:2)-u0u0)'*(train_data(find(train_data(:,3)==0),1:2)-u0u0)/length(find(train_data(:,3)==0))
%对u1矩阵进行扩展
u1u1=repmat(u1,length(find(train_data(:,3)==1)),1)
cigma1=(train_data(find(train_data(:,3)==1),1:2)-u1u1)'*(train_data(find(train_data(:,3)==1),1:2)-u1u1)/length(find(train_data(:,3)==1))
%根据上面的求解，我们得出了高斯分布的参数和伯努利分布的参数
%下面我们把两个高斯分布的等高线画出来
x0=40:1:180;
y0=300:1:550;
[X0,Y0]=meshgrid(x0,y0);
X=[X0(:) Y0(:)];
z0=mvnpdf(X,u0,cigma0);    %多元高斯分布函数
hold on
contour(X0,Y0,reshape(z0,length(y0),length(x0)))
z1=mvnpdf(X,u1,cigma1); 
contour(X0,Y0,reshape(z1,length(y0),length(x0)))
%对下面的10个点就行判断
for i=1:length(test_data)
    zz0=mvnpdf(test_data(i,1:2),u0,cigma0);
    result0=zz0*(1-fiv);
    zz1=mvnpdf(test_data(i,1:2),u1,cigma1);
    result1=zz1*fiv;
    if result0>result1
        disp('属于阿拉加斯州')
    else
        disp('属于加拿大')
    end
end