# KNN.m主要利用了KNN去识别0-9的数字，PCAandKNN.m主要是利用PCA对每个数字的特征进行降维，再进行KNN识别
## 数字识别的训练数据集和测试数据集都是32*32的矩阵，也就是每个数字都是1024个特征，其中的judge.m是对test数据进行判断属于哪个数字的，test_t.m主要是对test数据进行打标签，用于生成label,所有的数据集都在digits.zip这个压缩包内

![image](https://github.com/onlyonewater/Machine-Learing-in-MATLAB/raw/master/KNN/KNN.png)

![image](https://github.com/onlyonewater/Machine-Learing-in-MATLAB/raw/master/KNN/PCAandKNN.png)

## 第一张图片是直接运行KNN.m得到的，第二张是直接运行PCAandKNN.m得到的，我们可以看到利用PCA对数据进行降维的话，程序的运行效率提高了，即使错误率提高了，但是在我们可以接受的范围内
