## Linear regression 线性回归

* Topics:
  * Logistics and Recap
  * Random variable and distributions(continued)
  * Ordinary Linear Regression 普通线性回归

### QUESTIONS
  * what is the differences between data mining and machine learning
    * 在数据挖掘中，我们可以对参数解释，在机器学习中参数众多，我们无法准确对参数做解释。
    * 在机器学习中，我们处理的对象过程中有一个学习的过程，比如如何在已经识别猫狗的前提下，进一步识别猫站在狗身上。

### 线性回归
* 理论部分
  * 一种达到变量间关系的统计学过程
    * 响应变量(因变量,Y)
    * 预测变量(自变量,X)
  * 广泛应用于预测
  * 我们将研究最小二乘估计技术的方法 least squares estimation technique
  * 最简单的线性回归公式:![](./data_mining_31.png)
    * $\beta_0$和$\beta_1$也同样被称作模型系数、参数、权重。
    * 我们使用数据集获取$\beta_0$和$\beta_1$来对新的X值做预测。![](./data_mining_32.png)
  * 因为$\beta_0$和$\beta_1$是预估值，所以在获取新的$y_i$值时会有偏差。
    * 这些错误值(我们希望小)被叫做残余/剩余 ε。
      * 公式为:![](./data_mining_33.png)
      * $\hat\beta_0$和$\hat\beta_1$这些值被选作最小化剩余值的和(RSS,剩余值的平方和):![](./data_mining_34.png)
      * 换言之我们设置了以下优化公式:![](./data_mining_35.png)
    * 同样的$\hat\beta_0$和$\hat\beta_1$可以计算通过RSS公式:![](./data_mining_36.png)
    * 一旦我们有了$\hat\beta_0$和$\hat\beta_1$，对于X值的预测值可以通过下面公式获取:![](./data_mining_37.png)
    * 事实上，ε的值出现在所有出现偏差值的模型中:![](./data_mining_38.png)
  * 几何学解释 Geometric interpretation
    * ![](./data_mining_39.png)
    * ![](./data_mining_40.png)
    * ![](./data_mining_41.png)
      * 最好的回归线是哪个？
        * 平方和最小的
  * 当只有一个变量的时候线性回归的公式为:Y = β0 + β1X + ε
  * 当存在多个变量的时候线性回归的公式可以通用化为:Y = β0 + β1X1 + β2X2 + … + βnXn + ε
  * 例子:200*4的广告数据 ![](./data_mining_42.png)
    * 销售额是预测值
    * tv、radio、newspaper是变量
    * 在R中使用公式:lm(sales ~ radio, data = df)
      * 这里代表含义是sales的值依赖于radio
      * 如果需要加上额外变量sales ~ radio + TV
      * 如果变量非常多，可以表示为:sales ~ .
      * 如果参与预测的变量集中不包含某个变量:sales ~ -TV 表示预测变量中不包含TV