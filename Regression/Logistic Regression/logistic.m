function [theta_new,iter,lss]=logistic(data_x,label,theta)
%logistic回归
%data是输入的特征,label是标签，表示的0还是1
    alpha=0.00005;
    error=2e-5;
    iter=1;
    max_iter=100000;
    xx=ones(size(data_x,1),1);  %生成全是1的矩阵
    data_x=[xx,data_x];    %把截距项添加到data中
    while iter<=max_iter
        %h_theta=data*theta;
        for i=1:size(data_x,1)
            h_theta(i,1)=1/(1+exp(-data_x(i,:)*theta));
            L(i,1)=label(i)*h_theta(i,1)+(1-label(i))*log(1-h_theta(i,1));
        end
        loss=sum(L);
        lss(iter)=loss;
        %对参数theta的更新
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