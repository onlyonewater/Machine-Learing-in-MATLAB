function [theta_new,yy,iter,lss]=Batch_Gradient_descent(data,y,theta)
%�����ݶ��½�
%data������ľ���y������ľ���theta�ǳ�ʼ���Ĳ���
%theta_new�Ǿ����ݶ��½�������Ĳ��� lss��loss��ֵ iter�ǵ�������
    iter=1;
    max_iter=70000;                                                                                                                      
    alpha=0.00005;     %ѧϰ��
    error=1e-5;    %���
    %theta_new=theta;
    while iter<=max_iter
        %�ȼ���loss����
        for i=1:size(data,1)
            yy(i,1)=data(i,1:2)*theta;   %theta��������
        end
        loss=0.5*sum((yy-y).^2);
        lss(iter)=loss;
        %����theta�ĸ���
        for i=1:length(theta)
            theta(i,1)=theta(i,1)-alpha*sum((yy-y).*data(:,i));
        end
        if iter>=2&&abs(lss(iter)-lss(iter-1))<error  %��loss����
            theta_new=theta;
            break;
        end
        theta_new=theta;   
        iter=iter+1;
    end
end