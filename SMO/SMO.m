%SMO算法
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

%初始化参数alpha b初始迭代次数iter 最大迭代次数max_iter 我们允许的误差error=1e-5
%我们的C=10
alpha=zeros(1,length(data));b=0;iter=0;max_iter=3000;error=1e-5;C=5;
tic
while iter<max_iter
    count=0;
    for i=1:length(data)
        %首先选取第一个违反KKT条件最严重的那个点，将其对应的变量作为第一个参数
        %首先算出w
        w=alpha.*data(:,3)'*data(:,1:2);
        gxi=dot(w,data(i,1:2))+b;     %i的预测值
        ei=gxi-data(i,3);     %反映的是预测值和真实值之间的差值
        %找到违反最严重的那个点   为什么是这么表达的？
        if ei*data(i,3)<-error&&alpha(1,i)<C||ei*data(i,3)>error&&alpha(1,i)>0
            %那么我们接下来我们应该选取第二个变量alpha(1,j)
            %我们这儿是随机选取(为了简单)
            j=randperm(length(data),1);
            %我们需要计算j的预测值gxj和ej
            gxj=dot(w,data(j,1:2))+b;
            ej=gxj-data(j,3);
            %下面是alpha(1,i)和alpha(1,j)的更新
            alphaiold=alpha(1,i);    %old的alpha
            alphajold=alpha(1,j);
            %接下里我们需要知道L和H，就是alpha的边界,有y1==y2和y1!=y2的情况
            if data(i,3)==data(j,3)
                L=max(0,alphajold+alphaiold-C);
                H=min(C,alphajold+alphaiold);
            else
                L=max(0,alphajold-alphaiold);
                H=min(C,C+alphajold-alphaiold);
            end
            %下面是不考虑不等式约束的alphaj的更新
            %namt=k11+K22-2K12
            namt=dot(data(i,1:2),data(i,1:2))+dot(data(j,1:2),data(j,1:2))-dot(data(i,1:2),data(j,1:2));
            alphajnew_unc=alphajold+data(j,3)*(ei-ej)/(namt); 
            %下面是考虑不等式约束的情况,对alphaj的更新，即alphajnew
            if alphajnew_unc>H
                alphajnew=H;
            elseif alphajnew_unc<L
                alphajnew=L;
            else
                alphajnew=alphajnew_unc;
            end
            %接下来是alphai的更新，即alphainew
            alphainew=alphaiold+data(i,3)*data(j,3)*(alphajold-alphajnew);
            %将更新完的参数赋给alpha
            alpha(1,i)=alphainew;
            alpha(1,j)=alphajnew;
            %接下来我们需要更新b，先算出binew和bjnew
            binew=-ei-data(i,3)*dot(data(i,1:2),data(i,1:2))*(alphainew-alphaiold)-data(j,3)*dot(data(i,1:2),data(j,1:2))*(alphajnew-alphajold)+b;
            bjnew=-ej-data(i,3)*dot(data(i,1:2),data(j,1:2))*(alphainew-alphaiold)-data(j,3)*dot(data(j,1:2),data(j,1:2))*(alphajnew-alphajold)+b;
            %下面是更新b
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
        %跳出迭代的条件
        %如果所有的点都满足一定的范围error，那么跳出迭代
    end
    if count==length(data)   %所有点都满足误差条件
        disp(iter)
        disp('迭代成功')
        break;
    end
    iter=iter+1;
end
xx1=-2:0.1:10;
yy2=(w(1)*xx1+b)/(-w(2));
hold on
plot(xx1,yy2,'r')
toc