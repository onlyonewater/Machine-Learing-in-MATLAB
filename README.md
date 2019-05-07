# Machine-Learing-in-MATLAB
Application of machine learning in MATLAB

这个仓库目前包含了三个基本机器学习算法，分别是EM算法 SMO算法和k-means算法

在EM算法中，包含gaussian_compute.m和EM.m，我们利用了高斯混合模型（GMM）来对算法进行测试，我们定义了3个多元高斯分布模型，同时利用gaussian_compute.m来计算多元高斯分布的概率密度函数，最后执行EM.m来对参数进行估计

在SMO算法中，包含数据集q4_x.txt和q4_y.txt和SMO.m，我们利用数据集，来寻找SVM中的超平面，需要注意的是，这儿我们的SMO算法是简便的SMO算法，
也就是说我们在选取第二参数的时候，是随机选取的，而不是寻找了最大变换的参数，最后执行SMO.m找到分离超平面

在k-means算法中，包含k-means.m和数据集testSet.txt，我们利用k-means算法来对数据集进行分类，需要注意的是这儿我们是随机k的，所以有的时候效果不是很好，如果您想得到较好的效果，可以尝试k=4

特别需要注意的是，这儿的EM算法 SMO算法和k-means算法是入门级别的，不能满足您更高级的要求。SMO.m目前只支持线性可分的情况，如果您想运行这些程序，请将gaussian_compute.m或者q4_x.txt和q4_y.txt或者testSet.txt添加到您自己的路径

上述的算法均在MATLAB R2014a中测试通过
