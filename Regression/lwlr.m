function [f,iter,lss]=lwlr(data_x,data_y,theta,x,k)
%�ֲ���Ȩ���Իع�
%theta�ǲ��� ������
%x����Ҫ����Ԥ��ĺ����� k�Ǹ�˹�˵�k
    %�ȼ���loss
    alpha=0.00005;
    error=1e-5;    %���
    iter=1;
    max_iter=10000;
    while iter<=max_iter
        for i=1:size(data_x,1)
            %Ȩ��w
            w(i)=exp(-(data_x(i,2)-x)^2/(2*k^2));
            yy(i,1)=(data_x(i,:)*theta-data_y(i))*w(i);
        end
        loss=sum(yy);
        lss(iter)=loss;
        %�����ĸ���
        for i=1:length(theta)
            theta(i,1)=theta(i,1)-alpha*sum(yy.*data_x(:,i));
        end
        xx=[1,x];
        if iter>=2&&abs(lss(iter)-lss(iter-1))<error
            f=xx*theta;
            break;
        end
        f=xx*theta;   %��ֹ���㲻�����������ȱʡֵ
        iter=iter+1;
    end
end