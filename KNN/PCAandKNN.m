clc,clear
%这个程序利用KNN进行简单的数字识别0-9
%1-189行     0     %190-387   1
%388-582   2     %583-781   3
%782-967   4     %968-1154  5
%1155-1349 6     %1350-1550 7
%1551-1730 8     %1731-1934 9
%批量读取训练样本
tic
file=dir('F:\machinelearninginaction-master\Ch02\trainingDigits\*.txt');
data=zeros(32,32,length(file));
for k=1:length(file)
    t=textread(['F:\machinelearninginaction-master\Ch02\trainingDigits\',file(k).name],'%s');
    for i=1:length(t)
        for j=1:length(t{i})
            data(i,j,k)=str2num(t{i}(j));
        end
    end
end
%测试数据的读取
file_test=dir('F:\machinelearninginaction-master\Ch02\testDigits\*.txt');
data_test=zeros(32,32,length(file_test));
for k=1:length(file_test)
    t=textread(['F:\machinelearninginaction-master\Ch02\testDigits\',file_test(k).name],'%s');
    for i=1:length(t)
        for j=1:length(t{i})
            data_test(i,j,k)=str2num(t{i}(j));
        end
    end
end
%利用PCA对其进行降维
%先对训练样本进行降维
dat_train=data;
for i=1:length(dat_train)
    %行向量去减行向量的均值
    dd_train=bsxfun(@minus,dat_train(:,:,i),mean(dat_train(:,:,i),2));
    %列向量去减列向量的均值
    dy_train=bsxfun(@minus,dat_train(:,:,i),mean(dat_train(:,:,i),1));
    [V,D]=eig(dd_train*dd_train');    %D是矩阵对角化后的矩阵，V是特征向量
    [V_y,D_y]=eig(dy_train*dy_train');
    %观察我们的D,我们取10维的基向量作为主成分
    kk=10;
    dt=dat_train(:,:,i);
    %将数据降维到10*10的矩阵
    d_t(:,:,i)=V(end-kk+1:end,:)*dt*V_y(:,end-kk+1:end);
    DD(:,:,i)=D;
end
data=d_t;    %我们降维得到的新的数据
dat_test=data_test;
for i=1:length(dat_test)
    dd_test=bsxfun(@minus,dat_test(:,:,i),mean(dat_test(:,:,i),2));
    dy_test=bsxfun(@minus,dat_test(:,:,i),mean(dat_test(:,:,i),1));
    [V_test,D_test]=eig(dd_test*dd_test');    %D是矩阵对角化后的矩阵
    [Vy_test,Dy_test]=eig(dy_test*dy_test');
    %D_test=abs(D_test);
    %观察我们的D,我们取10维的基向量作为主成分
    kk=10;
    dt_test=dat_test(:,:,i);
    d_test(:,:,i)=V_test(end-kk+1:end,:)*dt_test*Vy_test(:,end-kk+1:end);
    DD_test(:,:,i)=D_test;
end
data_test=d_test;

%利用KNN进行识别
k=3;
for i=1:length(data_test)
    for j=1:length(data)
        distance(i,j)=norm(data_test(:,:,i)-data(:,:,j));
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