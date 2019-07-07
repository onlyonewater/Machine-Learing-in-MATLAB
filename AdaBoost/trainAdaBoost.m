function AdaboostClassifier=trainAdaBoost(dataFeatures, dataClass, numberOfIterations)
%numberOfIterations��ʾ���õ����������ĸ���
weight = ones(length(dataClass), 1) / length(dataClass); %��ʼ��Ȩ��
f=zeros(size(dataClass));
for i=1:numberOfIterations
    [weakClassifier,~,weakPredict]=BuildWeakClassify(dataFeatures,dataClass,weight);
    AdaboostClassifier(i).feature_d=weakClassifier.feature_d;
    AdaboostClassifier(i).error_d=weakClassifier.error_d;
    AdaboostClassifier(i).threshold_d=weakClassifier.threshold_d;
    AdaboostClassifier(i).alpha_d=weakClassifier.alpha_d;
    %Ȩ�صĸ���
    weight=weight.*exp(-dataClass.*AdaboostClassifier(i).alpha_d.*weakPredict);
    weight=weight./sum(weight);
    %���������������Ӻ���ܴ�����
    f=f+AdaboostClassifier(i).alpha_d*weakPredict;
    predictedClass = sign(f);
    AdaboostClassifier(i).total_error=sum(predictedClass ~= dataClass) / length(dataClass);
    if AdaboostClassifier(i).total_error==0
        break;
    end
end
end