function f=word_judge(test,train_ham,train_spam)
%�ж�test�����ĸ����(spam or ham)
%���f=1��ʾ�����ʼ� f=0��ʾ�����ʼ�
    %���ȶ�train_ham��train_spam����ͳ��
    tabel_ham=tabulate(train_ham);
    tabel_spam=tabulate(train_spam);
    %����ham��result
    result_ham=1;
    for i=1:length(test)
        count_ham=0;
        if ismember(test{i},tabel_ham(:,1))==1
            [~,loc]=ismember(test{i},tabel_ham(:,1));
            count_ham=tabel_ham{loc,2}(1);
        else
            count_ham=count_ham+1;   %������˹ƽ��
        end
        result_ham=result_ham*count_ham/(length(train_ham)+2);
    end
    %����spam��result
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
        %���������ʼ�
        f=1;
    else
        %�������ʼ�
        f=0;
    end
end