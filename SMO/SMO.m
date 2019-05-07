%SMO�㷨
clc,clear
data=importdata('F:\machinelearninginaction-master\Ch06\testSet.txt');
for i=1:length(data)
    if data(i,3)==1
        plot(data(i,1),data(i,2),'*');
        hold on
    else
        plot(data(i,1),data(i,2),'o');
        hold on
    end
end

%��ʼ������alpha b��ʼ��������iter ����������max_iter ������������error=1e-5
%���ǵ�C=10
alpha=zeros(1,length(data));b=0;iter=0;max_iter=3000;error=1e-5;C=5;
tic
while iter<max_iter
    count=0;
    for i=1:length(data)
        %����ѡȡ��һ��Υ��KKT���������ص��Ǹ��㣬�����Ӧ�ı�����Ϊ��һ������
        %�������w
        w=alpha.*data(:,3)'*data(:,1:2);
        gxi=dot(w,data(i,1:2))+b;     %i��Ԥ��ֵ
        ei=gxi-data(i,3);     %��ӳ����Ԥ��ֵ����ʵֵ֮��Ĳ�ֵ
        %�ҵ�Υ�������ص��Ǹ���   Ϊʲô����ô���ģ�
        if ei*data(i,3)<-error&&alpha(1,i)<C||ei*data(i,3)>error&&alpha(1,i)>0
            %��ô���ǽ���������Ӧ��ѡȡ�ڶ�������alpha(1,j)
            %������������ѡȡ(Ϊ�˼�)
            j=randperm(length(data),1);
            %������Ҫ����j��Ԥ��ֵgxj��ej
            gxj=dot(w,data(j,1:2))+b;
            ej=gxj-data(j,3);
            %������alpha(1,i)��alpha(1,j)�ĸ���
            alphaiold=alpha(1,i);    %old��alpha
            alphajold=alpha(1,j);
            %������������Ҫ֪��L��H������alpha�ı߽�,��y1==y2��y1!=y2�����
            if data(i,3)==data(j,3)
                L=max(0,alphajold+alphaiold-C);
                H=min(C,alphajold+alphaiold);
            else
                L=max(0,alphajold-alphaiold);
                H=min(C,C+alphajold-alphaiold);
            end
            %�����ǲ����ǲ���ʽԼ����alphaj�ĸ���
            %namt=k11+K22-2K12
            namt=dot(data(i,1:2),data(i,1:2))+dot(data(j,1:2),data(j,1:2))-dot(data(i,1:2),data(j,1:2));
            alphajnew_unc=alphajold+data(j,3)*(ei-ej)/(namt); 
            %�����ǿ��ǲ���ʽԼ�������,��alphaj�ĸ��£���alphajnew
            if alphajnew_unc>H
                alphajnew=H;
            elseif alphajnew_unc<L
                alphajnew=L;
            else
                alphajnew=alphajnew_unc;
            end
            %��������alphai�ĸ��£���alphainew
            alphainew=alphaiold+data(i,3)*data(j,3)*(alphajold-alphajnew);
            %��������Ĳ�������alpha
            alpha(1,i)=alphainew;
            alpha(1,j)=alphajnew;
            %������������Ҫ����b�������binew��bjnew
            binew=-ei-data(i,3)*dot(data(i,1:2),data(i,1:2))*(alphainew-alphaiold)-data(j,3)*dot(data(i,1:2),data(j,1:2))*(alphajnew-alphajold)+b;
            bjnew=-ej-data(i,3)*dot(data(i,1:2),data(j,1:2))*(alphainew-alphaiold)-data(j,3)*dot(data(j,1:2),data(j,1:2))*(alphajnew-alphajold)+b;
            %�����Ǹ���b
            if alphainew<C&&alphainew>0
                b=binew;
            elseif alphajnew<C&&alphajnew>0
                b=bjnew;
            else
                b=(binew+bjnew)/2;
            end
        else
            count=count+1;
        end
        %��������������
        %������еĵ㶼����һ���ķ�Χerror����ô��������
    end
    if count==length(data)   %���е㶼�����������
        disp(iter)
        disp('�����ɹ�')
        break;
    end
    iter=iter+1;
end
xx1=-2:0.1:10;
yy2=(w(1)*xx1+b)/(-w(2));
hold on
plot(xx1,yy2,'r')
toc