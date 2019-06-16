clc,clear
data=importdata('C:\Users\一滴水\Desktop\LDA.txt');
number=randperm(size(data,1),70);
train=data(number,:);
n=[];
for i=1:size(data,1)
    if ismember(i,number)==0
        n=[n,i];
    end
end
test=data(n,:);
w=LDA(train);
judge=[];    %分类结果
for i=1:size(test,1)
    f(i,1)=w*test(i,1:end-1)';
    if f(i,1)>-0.3
        judge=[judge,1];
    else
        judge=[judge,2];
    end
end
