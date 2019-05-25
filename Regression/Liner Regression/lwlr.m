function [f,iter,lss]=lwlr(data_x,data_y,theta,x,k)
%局部加权线性回归
%theta是参数 列向量
%x是需要进行预测的横坐标 k是高斯核的k
    %先计算loss
    alpha=0.00005;
    error=1e-5;    %误差
    iter=1;
    max_iter=10000;
    while iter<=max_iter
        for i=1:size(data_x,1)
            %权重w
            w(i)=exp(-(data_x(i,2)-x)^2/(2*k^2));
            yy(i,1)=(data_x(i,:)*theta-data_y(i))*w(i);
        end
        loss=sum(yy);
        lss(iter)=loss;
        %参数的更新
        for i=1:length(theta)
            theta(i,1)=theta(i,1)-alpha*sum(yy.*data_x(:,i));
        end
        xx=[1,x];
        if iter>=2&&abs(lss(iter)-lss(iter-1))<error
            f=xx*theta;
            break;
        end
        f=xx*theta;   %防止满足不了条件，造成缺省值
        iter=iter+1;
    end
end