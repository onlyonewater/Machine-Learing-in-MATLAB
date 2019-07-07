function [weakClassifier,alpha,weakPredict]=BuildWeakClassify(dataFeature,dataClass,weight)
%������������
%weakClassifier�ǵõ�����������
%alpha��ϵ����Ҳ�������Ϊ����
%weakPredict�����������õ��Ľ��
minFeature=min(dataFeature,[],1);     %�ҵ�Feature����Сֵ
maxFeature=max(dataFeature,[],1);     %�ҵ�Feature����Сֵ
%�����Ƕ�ά�����ݣ������ǲ�������������ֱ�ߵ�˼��
for feature=1:size(dataFeature,2)
    %�ж���ѡ��x�ϵ�ֱ�߻���y�ϵ�ֱ��
    interval=linspace(minFeature(feature),maxFeature(feature),1000);%���
    for i=1:length(interval)
        %�ж�interval������
        for row=1:size(dataFeature,1)
            if dataFeature(row,feature)>interval(i)
                establish(row,1)=1;
            else
                establish(row,1)=-1;
            end
        end
        error(i)=sum(weight(find(establish~=dataClass)));   %������
    end
    [mid_var(feature),location]=min(error);%�ҵ���ô���interval�д�������С���Ǹ�
    threshold(feature)=interval(location);
end
[error_r,direction]=min(mid_var);
alpha=1/2*log((1-error_r)/error_r);   %ϵ��
weakClassifier.feature_d=direction;
weakClassifier.error_d=error_r;
weakClassifier.threshold_d=threshold(direction);
weakClassifier.alpha_d=alpha;
%�õ�weakPredict
for i=1:size(dataFeature,1)
    if dataFeature(i,direction)>threshold
        weakPredict(i,1)=1;
    else
        weakPredict(i,1)=-1;
    end
end
end