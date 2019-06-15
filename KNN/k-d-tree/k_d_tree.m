clc,clear
data=[2,4,5,7,8,9;3,7,4,2,1,6]';
tree=CreatTree(data);
point=[1,10];
plot(data(:,1),data(:,2),'r*')
hold on
plot_tree(tree,point)
searchTree(tree,[2.3,4.3])