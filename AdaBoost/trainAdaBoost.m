function AdaboostClassifier=trainAdaBoost(dataFeatures, dataClass, numberOfIterations)
%numberOfIterations表示采用的弱分类器的个数
weight = ones(length(dataClass), 1) / length(dataClass); %初始化权重
f=zeros(size(dataClass));
for i=1:numberOfIterations
    [weakClassifier,~,weakPredict]=BuildWeakClassify(dataFeatures,dataClass,weight);
    AdaboostClassifier(i).feature_d=weakClassifier.feature_d;
    AdaboostClassifier(i).error_d=weakClassifier.error_d;
    AdaboostClassifier(i).threshold_d=weakClassifier.threshold_d;
    AdaboostClassifier(i).alpha_d=weakClassifier.alpha_d;
    %权重的更新
    weight=weight.*exp(-dataClass.*AdaboostClassifier(i).alpha_d.*weakPredict);
    weight=weight./sum(weight);
    %计算弱分类器叠加后的总错误率
    f=f+AdaboostClassifier(i).alpha_d*weakPredict;
    predictedClass = sign(f);
    AdaboostClassifier(i).total_error=sum(predictedClass ~= dataClass) / length(dataClass);
    if AdaboostClassifier(i).total_error==0
        break;
    end
end
end