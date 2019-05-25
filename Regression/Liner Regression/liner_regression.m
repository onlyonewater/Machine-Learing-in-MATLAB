clc,clear
%liner regression
data=importdata('F:\machinelearninginaction-master\Ch08\ex0.txt');
plot(data(:,2),data(:,3),'r*')
hold on
theta=[0,0]';
%[theta_new,yy,iter,lss]=Batch_Gradient_descent(data(:,1:2),data(:,3),theta);
[theta_new,yy,iter,lss]=Stochastic_Gradient_descent(data(:,1:2),data(:,3),theta);
plot(data(:,2),yy,'b')


