clc,clear
data=importdata('F:\machinelearninginaction-master\Ch05\testSet.txt');
plot(data(:,1),data(:,2),'o')
hold on
theta=[0,0,0]';
[theta_new,iter,lss]=logistic(data(:,1:2),data(:,3),theta);
xx=-4:0.1:4;
yy=(theta_new(1)+theta_new(2)*xx)/(-theta_new(3));
%»­³ö·Ö¸îÏß
plot(xx,yy,'r')