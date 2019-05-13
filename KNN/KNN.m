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