# Machine-Learing-in-MATLAB
Application of machine learning in MATLAB

这个仓库目前包含了两个基本机器学习算法，分别是EM算法和SMO算法，在EM算法中，我们利用了高斯混合模型（GMM）来对算法进行测试，我们定义了3个多元高斯分布模型，
同时利用gaussian_compute.m来计算多元高斯分布的概率密度函数，最后执行EM.m来对参数进行估计

在SMO算法中，我们的数据集是q4_x.txt和q4_y.txt，我们利用数据集，来寻找SVM中的超平面，需要注意的是，这儿我们的SMO算法是简便的SMO算法，
也就是说我们在选取第二参数的时候，是随机选取的，而不是寻找了最大变换的参数，最后执行SMO.m找到分离超平面

特别需要注意的是，这儿的EM算法和SMO算法是入门级别的，不能满足您更高级的要求。SMO.m目前只支持线性可分的情况
