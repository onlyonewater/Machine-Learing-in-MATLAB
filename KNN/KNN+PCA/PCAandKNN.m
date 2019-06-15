clc,clear
%这个程序利用KNN进行简单的数字识别0-9
%1-189行     0     %190-387   1
%388-582   2     %583-781   3
%782-967   4     %968-1154  5
%1155-1349 6     %1350-1550 7
%1551-1730 8     %1731-1934 9
tic
%批量读取训练样本
file=dir('F:\machinelearninginaction-master\Ch02\trainingDigits\*.txt');
data=zeros(32,32,length(file));
data_train=zeros(32*32,length(file));
for k=1:length(file)
    t=textread(['F:\machinelearninginaction-master\Ch02\trainingDigits\',file(k).name],'%s');
    for i=1:length(t)
        for j=1:length(t{i})
            data(i,j,k)=str2num(t{i}(j));
        end
    end
    dat_t=data(:,:,k);
    data_train(:,k)=reshape(dat_t,1024,1);
end

%批量测试数据的读取
file_test=dir('F:\machinelearninginaction-master\Ch02\testDigits\*.txt');
dat_test=zeros(32,32,length(file_test));
data_test=zeros(32*32,length(file_test));
for k=1:length(file_test)
    t=textread(['F:\machinelearninginaction-master\Ch02\testDigits\',file_test(k).name],'%s');
    for i=1:length(t)
        for j=1:length(t{i})
            dat_test(i,j,k)=str2num(t{i}(j));
        end
    end
    ddy=dat_test(:,:,k);
    %data_test(:,k)=ddy(:);    %我们的test数据
    data_test(:,k)=reshape(ddy,1024,1);
end

%接下来是PCA进行降维
kk=20;   %选取kk个主成分
data_train_mean=mean(data_train,2);
dd_train=bsxfun(@minus,data_train,data_train_mean);
%计算协方差矩阵的特征值D和特征向量V，取前kk个，按D的从大到小排列
[V_train,D_train]=eigs(dd_train*dd_train',kk);
data_train=V_train'*dd_train;    %降维得到的矩阵
%train数据归一化
for i=1:size(data_train,2)
    for j=1:size(data_train,1)
        data_train(j,i)=data_train(j,i)/norm(data_train(:,i));
    end
end

%对test数据进行降维
data_test_mean=mean(data_test,2);
dd_test=bsxfun(@minus,data_test,data_test_mean);
data_test=V_train'*dd_test;    %降维得到的矩阵
%test数据归一化
for i=1:size(data_test,2)
    for j=1:size(data_test,1)
        data_test(j,i)=data_test(j,i)/norm(data_test(:,i));
    end
end

%利用KNN进行手写识别
k=3;
[m_test,n_test]=size(data_test);
[m_train,n_train]=size(data_train);
for i=1:n_test
    for j=1:n_train
        distance(i,j)=norm(data_test(:,i)-data_train(:,j));
    end
end

dd=distance;
dd=sort(dd,2);     %进行排列
%取前k个数据
dd(:,k+1:end)=[];
for i=1:length(dd)
    [m,n]=ismember(dd(i,:),distance(i,:));
    %对n进行judge
    panduan(i)=judge(n);
end

test_panduan=test_t(length(file_test));
result=panduan-test_panduan;
res=find(result==0);
error=1-length(res)/length(file_test)
toc