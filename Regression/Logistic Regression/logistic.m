function [theta_new,iter,lss]=logistic(data_x,label,theta)
%logistic�ع�
%data�����������,label�Ǳ�ǩ����ʾ��0����1
    alpha=0.00005;
    error=2e-5;
    iter=1;
    max_iter=100000;
    xx=ones(size(data_x,1),1);  %����ȫ��1�ľ���
    data_x=[xx,data_x];    %�ѽؾ�����ӵ�data��
    while iter<=max_iter
        %h_theta=data*theta;
        for i=1:size(data_x,1)
            h_theta(i,1)=1/(1+exp(-data_x(i,:)*theta));
            L(i,1)=label(i)*h_theta(i,1)+(1-label(i))*log(1-h_theta(i,1));
        end
        loss=sum(L);
        lss(iter)=loss;
        %�Բ���theta�ĸ���
        for i=1:length(theta)
            theta(i,1)=theta(i,1)+alpha*sum((label-h_theta).*data_x(:,i));           
        end
        if iter>=2&&abs(lss(iter)-lss(iter-1))<error
            theta_new=theta;
            break;
        end
        theta_new=theta;
        iter=iter+1;
    end
end