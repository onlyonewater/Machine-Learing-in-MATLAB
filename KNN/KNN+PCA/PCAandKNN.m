clc,clear
%�����������KNN���м򵥵�����ʶ��0-9
%1-189��     0     %190-387   1
%388-582   2     %583-781   3
%782-967   4     %968-1154  5
%1155-1349 6     %1350-1550 7
%1551-1730 8     %1731-1934 9
tic
%������ȡѵ������
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

%�����������ݵĶ�ȡ
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
    %data_test(:,k)=ddy(:);    %���ǵ�test����
    data_test(:,k)=reshape(ddy,1024,1);
end

%��������PCA���н�ά
kk=20;   %ѡȡkk�����ɷ�
data_train_mean=mean(data_train,2);
dd_train=bsxfun(@minus,data_train,data_train_mean);
%����Э������������ֵD����������V��ȡǰkk������D�ĴӴ�С����
[V_train,D_train]=eigs(dd_train*dd_train',kk);
data_train=V_train'*dd_train;    %��ά�õ��ľ���
%train���ݹ�һ��
for i=1:size(data_train,2)
    for j=1:size(data_train,1)
        data_train(j,i)=data_train(j,i)/norm(data_train(:,i));
    end
end

%��test���ݽ��н�ά
data_test_mean=mean(data_test,2);
dd_test=bsxfun(@minus,data_test,data_test_mean);
data_test=V_train'*dd_test;    %��ά�õ��ľ���
%test���ݹ�һ��
for i=1:size(data_test,2)
    for j=1:size(data_test,1)
        data_test(j,i)=data_test(j,i)/norm(data_test(:,i));
    end
end

%����KNN������дʶ��
k=3;
[m_test,n_test]=size(data_test);
[m_train,n_train]=size(data_train);
for i=1:n_test
    for j=1:n_train
        distance(i,j)=norm(data_test(:,i)-data_train(:,j));
    end
end

dd=distance;
dd=sort(dd,2);     %��������
%ȡǰk������
dd(:,k+1:end)=[];
for i=1:length(dd)
    [m,n]=ismember(dd(i,:),distance(i,:));
    %��n����judge
    panduan(i)=judge(n);
end

test_panduan=test_t(length(file_test));
result=panduan-test_panduan;
res=find(result==0);
error=1-length(res)/length(file_test)
toc