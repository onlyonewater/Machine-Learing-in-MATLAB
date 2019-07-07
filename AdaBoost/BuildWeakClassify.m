function [weakClassifier,alpha,weakPredict]=BuildWeakClassify(dataFeature,dataClass,weight)
%构建弱分类器
%weakClassifier是得到的弱分类器
%alpha是系数，也可以理解为几率
%weakPredict是弱分类器得到的结果
minFeature=min(dataFeature,[],1);     %找到Feature的最小值
maxFeature=max(dataFeature,[],1);     %找到Feature的最小值
%由于是二维的数据，故我们采用弱分类器是直线的思想
for feature=1:size(dataFeature,2)
    %判断是选择x上的直线还是y上的直线
    interval=linspace(minFeature(feature),maxFeature(feature),1000);%间隔
    for i=1:length(interval)
        %判断interval错误率
        for row=1:size(dataFeature,1)
            if dataFeature(row,feature)>interval(i)
                establish(row,1)=1;
            else
                establish(row,1)=-1;
            end
        end
        error(i)=sum(weight(find(establish~=dataClass)));   %错误率
    end
    [mid_var(feature),location]=min(error);%找到这么多个interval中错误率最小的那个
    threshold(feature)=interval(location);
end
[error_r,direction]=min(mid_var);
alpha=1/2*log((1-error_r)/error_r);   %系数
weakClassifier.feature_d=direction;
weakClassifier.error_d=error_r;
weakClassifier.threshold_d=threshold(direction);
weakClassifier.alpha_d=alpha;
%得到weakPredict
for i=1:size(dataFeature,1)
    if dataFeature(i,direction)>threshold
        weakPredict(i,1)=1;
    else
        weakPredict(i,1)=-1;
    end
end
end