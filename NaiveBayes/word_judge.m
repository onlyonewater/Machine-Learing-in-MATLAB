function f=word_judge(test,train_ham,train_spam)
%判断test属于哪个类别(spam or ham)
%如果f=1表示正常邮件 f=0表示垃圾邮件
    %首先对train_ham和train_spam进行统计
    tabel_ham=tabulate(train_ham);
    tabel_spam=tabulate(train_spam);
    %计算ham的result
    result_ham=1;
    for i=1:length(test)
        count_ham=0;
        if ismember(test{i},tabel_ham(:,1))==1
            [~,loc]=ismember(test{i},tabel_ham(:,1));
            count_ham=tabel_ham{loc,2}(1);
        else
            count_ham=count_ham+1;   %拉普拉斯平滑
        end
        result_ham=result_ham*count_ham/(length(train_ham)+2);
    end
    %计算spam的result
    result_spam=1;
    for i=1:length(test)
        count_spam=0;
        if ismember(test{i},tabel_spam(:,1))==1
            [~,loc]=ismember(test{i},tabel_spam(:,1));
            count_spam=tabel_spam{loc,2}(1);
        else
            count_spam=count_spam+1;
        end
        result_spam=result_spam*count_spam/(length(train_spam)+2);
    end
    if result_ham>result_spam
        %不是垃圾邮件
        f=1;
    else
        %是垃圾邮件
        f=0;
    end
end