clc,clear
%�����������KNN���м򵥵�����ʶ��0-9
%1-189��     0     %190-387   1
%388-582   2     %583-781   3
%782-967   4     %968-1154  5
%1155-1349 6     %1350-1550 7
%1551-1730 8     %1731-1934 9
%������ȡѵ������
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
%�������ݵĶ�ȡ
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
%����PCA������н�ά
%�ȶ�ѵ���������н�ά
dat_train=data;
for i=1:length(dat_train)
    %������ȥ���������ľ�ֵ
    dd_train=bsxfun(@minus,dat_train(:,:,i),mean(dat_train(:,:,i),2));
    %������ȥ���������ľ�ֵ
    dy_train=bsxfun(@minus,dat_train(:,:,i),mean(dat_train(:,:,i),1));
    [V,D]=eig(dd_train*dd_train');    %D�Ǿ���Խǻ���ľ���V����������
    [V_y,D_y]=eig(dy_train*dy_train');
    %�۲����ǵ�D,����ȡ10ά�Ļ�������Ϊ���ɷ�
    kk=10;
    dt=dat_train(:,:,i);
    %�����ݽ�ά��10*10�ľ���
    d_t(:,:,i)=V(end-kk+1:end,:)*dt*V_y(:,end-kk+1:end);
    DD(:,:,i)=D;
end
data=d_t;    %���ǽ�ά�õ����µ�����
dat_test=data_test;
for i=1:length(dat_test)
    dd_test=bsxfun(@minus,dat_test(:,:,i),mean(dat_test(:,:,i),2));
    dy_test=bsxfun(@minus,dat_test(:,:,i),mean(dat_test(:,:,i),1));
    [V_test,D_test]=eig(dd_test*dd_test');    %D�Ǿ���Խǻ���ľ���
    [Vy_test,Dy_test]=eig(dy_test*dy_test');
    %D_test=abs(D_test);
    %�۲����ǵ�D,����ȡ10ά�Ļ�������Ϊ���ɷ�
    kk=10;
    dt_test=dat_test(:,:,i);
    d_test(:,:,i)=V_test(end-kk+1:end,:)*dt_test*Vy_test(:,end-kk+1:end);
    DD_test(:,:,i)=D_test;
end
data_test=d_test;

%����KNN����ʶ��
k=3;
for i=1:length(data_test)
    for j=1:length(data)
        distance(i,j)=norm(data_test(:,:,i)-data(:,:,j));
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