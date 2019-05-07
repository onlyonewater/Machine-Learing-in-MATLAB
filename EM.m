clc,clear
M=3;    %M����˹��Ϸֲ�
N=600;  %�����ĸ���
%����ʽ�ֲ��ĸ���
Multinoulli=[2/3,1/6,1/6];
%��Ԫ��˹�ֲ��ľ�ֵ
mu=[3 5;4 3;6 7];
%��Ԫ��˹�ֲ���Э����
sigma(:,:,1)=[5 0;0 0.2];
sigma(:,:,2)=[0.1 0;0 0.1];
sigma(:,:,3)=[0.1 0;0 0.1];
%���ǲ���������x
x=[mvnrnd(mu(1,:),sigma(:,:,1),N*Multinoulli(1));...
   mvnrnd(mu(2,:),sigma(:,:,2),N*Multinoulli(2));...
   mvnrnd(mu(3,:),sigma(:,:,3),N*Multinoulli(3))];

%��ϸ�˹�ֲ����������ĳ�ʼ��
Multinoulli_train=[1/3,1/3,1/3];
mu_train=[1 2;2 1;3 4];
sigma_train(:,:,1)=[1 0;0 1];
sigma_train(:,:,2)=[1 0;0 1];
sigma_train(:,:,3)=[1 0;0 1];

%���������� ��ʼ��������
max_iter=1000;iter=1;
%���
error=1e-5;
t_res=0;
while iter<max_iter
    %E-Step
    for i=1:N
        for j=1:M
            pr(i,j)=gaussian_compute(x(i,:),mu_train(j,:),sigma_train(:,:,j))*Multinoulli_train(j);
        end
    end
    Q_i=bsxfun(@rdivide,pr,sum(pr,2));
    %M-Step
    Q_isum=sum(Q_i,1);
    Multinoulli_train=Q_isum/N;
    for i=1:M
        pw=zeros(1,2);
        for j=1:N
            pw=pw+Q_i(j,i)*x(j,:);
        end
        mu_train(i,:)=pw./Q_isum(i);
    end
    
    for i=1:M
        ps=zeros(2);
        for j=1:N
            ps=ps+((x(j,:)-mu_train(i,:))'*(x(j,:)-mu_train(i,:)))*Q_i(j,i);
        end
        sigma_train(:,:,i)=ps./Q_isum(i);
    end
    

    t1=norm(Multinoulli_train(:)-Multinoulli(:));   
    t2=norm(mu_train(:)-mu(:));            
    t3=norm(sigma_train(:)-sigma(:));              
    
    t=max([t1;t2;t3])

    if abs(t-t_res)<error    %�����������С��һ��������ô��������
        break;
    end
    t_res=t;
    iter=iter+1;
end