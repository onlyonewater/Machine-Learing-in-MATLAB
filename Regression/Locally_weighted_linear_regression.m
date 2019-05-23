clc,clear
%Locally weighted linear regression
data=importdata('F:\machinelearninginaction-master\Ch08\ex0.txt');
plot(data(:,2),data(:,3),'r*')
k=1;
for i=1:size(data,1)
    x=data(i,2);
    theta=[0,0]';
    [f,iter,lss]=lwlr(data(:,1:2),data(:,3),theta,x,k);
    y(i,1)=f;
end
hold on
plot(data(:,2),y,'b')
