clc,clear
N=25;   %表示垃圾邮件和正常邮件分别有25封
%利用随机数得到train和test

train_count_ham=randperm(25,22);
train_count_spam=randperm(25,22);

test_count_ham=[];test_count_spam=[];
for i=1:N
    if ismember(i,train_count_ham)==0
        test_count_ham=[test_count_ham,i];
    end
    if ismember(i,train_count_spam)==0
        test_count_spam=[test_count_spam,i];
    end
end
path_ham='F:\machinelearninginaction-master\Ch04\email\ham\';
path_spam='F:\machinelearninginaction-master\Ch04\email\spam\';
expr_ham=' |,|?|"|:|))|/|[0-9]|(|)|\.';
expr_spam=' |,|?|"|:|))|/|[0-9]|(|)|\.|%|---|--|&|!|\$|\(|\)|-';
%train数据
train_ham_email=Construct_word_vector(path_ham,train_count_ham,expr_ham);
train_spam_email=Construct_word_vector(path_spam,train_count_spam,expr_spam);
%ham_test
for i=1:length(test_count_ham)
    test_ham_email=Construct_word_vector(path_ham,test_count_ham(i),expr_ham);
    f=word_judge(test_ham_email,train_ham_email,train_spam_email);
    if f==1
        disp('正常邮件')
    else
        disp('垃圾邮件')
    end
end
%spam_test
for i=1:1:length(test_count_spam)
    test_spam_email=Construct_word_vector(path_spam,test_count_spam(i),expr_spam);
    f=word_judge(test_spam_email,train_ham_email,train_spam_email);
    if f==1
        disp('正常邮件')
    else
        disp('垃圾邮件')
    end
end


