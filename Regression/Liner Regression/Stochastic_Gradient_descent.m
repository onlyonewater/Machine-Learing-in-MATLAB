function [theta_new,yy,iter,lss]=Stochastic_Gradient_descent(data,y,theta)
%随机梯度下降
%data是输入的矩阵，y是输出的矩阵，theta是初始化的参数
%theta_new是经过梯度下降更新完的参数 lss是loss的值 iter是迭代次数
    iter=1;
    max_iter=100000;
    alpha=1/iter;      %学习率 动态的改变学习率
    error=1e-5;    %误差
    theta_new=theta;
    while iter<=max_iter
        %先计算函数的loss值
        for i=1:size(data,1)
            yy(i,1)=data(i,1:2)*theta;
        end
        loss=0.5*sum((yy-y).^2);
        lss(iter)=loss;
        %生成随机数
        k=unidrnd(size(data,1));
        yyk=data(k,1:2)*theta;
        %参数的更新
        for i=1:length(theta)
            theta(i,1)=theta(i,1)-alpha*(yyk-y(k,1))*data(k,i);
        end
        if iter>=2&&abs(lss(iter)-lss(iter-1))<error  %让loss收敛
            theta_new=theta;
            break;
        end
        theta_new=theta;
        iter=iter+1;
    end
end