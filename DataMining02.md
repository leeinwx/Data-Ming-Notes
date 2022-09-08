## Lecture 02 Random variables, measures of central tendency and distributions 随机变量 集中趋势的度量 分布

* Topics:
  * Logistics and Recap
  * Introduction(continued)
  * Random variable and distributions

* 注意:任何的数据研究都需要提前深入了解现有的数据是什么、代表什么含义，只有在足够深入了解现有数据的基础上才可以做算法分析、数据处理等操作.
* tips:https://lexfridman.com/

#### 数据挖掘是个新领域吗？
![死亡地图](/data_mining_1.png)
* 1854年伦敦霍乱，约翰·斯诺根据死亡地图推断出水井是导致霍乱传染的根源
  
* 数据挖掘 vs 机器学习
  * 数据挖掘:一个跨学科领域拥有大数据集，专注于发掘模型(数学、计算机科学、软件工程、debug、可视化、社会分析、心理学)
  * 这是如何完成的？
    * 机器学习是一种方式(使用算法发现数据集中的模型) 在连串的语句中，机器需要填充所在预警与回忆之前的语句
  * 机器学习就在我们周围
    * Netfilx
    * Google
    * Amazon
    * imdb
  * 我们听说过很多故事，自动驾驶汽车、情绪感音环境，为什么尿片和啤酒会放在一起等等

    | 计算机科学 | 机器学习 |
    | :----- | :---- |
    | 确定的规则 | 泛化/归纳是关键Generalization |
    | 错误是无法容忍的 | 错误是景观的一部分</br>&emsp;新冠检测</br>&emsp;自动驾驶 |
    | 算法不会学习而被提供 | 算法学习(反向传播backprop、遗传编程genetic programming) |
    | 编程(数据)==> 输出 程序本身最重要 | 数据(程序)==> 模型 ==>输出 数据本身最重要 |

  * 机器学习的问题:会归纳出之前没见过的结果
    * 但是我们可以简单的看到所有的数据吗？
  * 数据挖掘与机器学习的讨论
    * ACM KDD (Knowledge Discovery and Data Mining), http://www.kdd.org
    * ICML (International Conference on Machine Learning)
    * ACM CIKM (International Conference on Information and Knowledge Management)
    * SDM (SIAM International Conference on Data Mining)
    * NeurIPS
  * 期刊
    * IEEE Transactions on Pattern Analysis and Machine Intelligence
    * ACM Transactions on Knowledge Discovery from Data
    * IEEE Transactions on Knowledge and Data Engineering
  * 相关资源
    * Kaggle (https://www.kaggle.com)
    * Kdnuggets (https://www.kdnuggets.com)
    * https://machinelearningmastery.com
    * https://towardsdatascience.com
  
#### 随机变量 Random variables
* 随机变量，X是一个变量，其可能的值是从一个随机环境中获取
  * 投掷硬币
  * 掷骰子
* 两种类型
  * 离散
  * 连续

* 总体Population vs 样本sample
  * 假定现在有个列向量，D:
    * $D = \begin{pmatrix}X \\-\\x_1\\x_2\\...\\x_n \end{pmatrix} \quad X \in \R^n$
  * 我们假设这些数据都是随机样本从X中取出，每个$x_i$都是独立的(iid)
  * 通常来说，从X中取出的分布都是未知的，并且矩也是未知的(moment)
    * 零阶矩，(概率)质量的总和，也就是1
    * 一阶原点矩，即均值mean，衡量数据的平均水平 表位置
    * 二阶中心矩，方差variance，衡量数据的离散/集中程度 表胖瘦
    * 二阶原点矩，$EX^2$，衡量数据移动至平均位置所需要的平均能量
    * 三阶中心矩，偏度，衡量偏离中心的点的位置情况，也就是偏离中心的点的平均水平(正负、大小) 表歪斜
    * 四阶中心矩kurtosis，峰度，俗称方差的方差，衡量偏离中心的点的密集程度，是俗话说的尖峰厚尾的理论基础 表尾巴胖瘦
    * 我们仅有样本，希望取出的样本内分布接近总体内分布
    * ![](/data_mining_2.png)
      * 从上图展示的内容来看，图A内数据相对分散，图B数据更加聚类话，对于机器学习和数据挖掘来说更愿意分析/处理图A数据，图B的数据最终可以得到的结论只能是在有点大那块区间内.图A中既存在了部分聚类也出现了部分分散的情况，就数据方来看更具说服力，我们想要离散更高的数据集.
  * 假定我们给出离散随机变量X，有以下几种概率分布
    * $$
    \begin{cases}
    1&20\%\\
    2&30\%\\
    3&40\%\\
    4&10\%
    \end{cases}
    $$
    * 那么随机变量X的出现概率可以用以下公式和直方图表示
      * $$
      \hat{f}(x)=P(X=x)=\frac{1}{n}\displaystyle\sum_{i=1}^nI(x_i=x)
      $$
      where
      $$
      I(x_i=x)=\begin{cases}
      1& if&x_i=x\\
      0& if&x_i\neq{x}
    \end{cases}
      $$
      * ![](/data_mining_3.png)
    ``` R
    x <- c(1,1,2,2,2,3,3,3,4)
    a <- hist(x, c(0.0,1.0,2.0,3.0,4.0))
    plot(a)
    ```
    ![](/data_mining_4.png)
  * 与PMF(probability mass function)相关的是PDF(probability density function) 
    * PMF:概率质量函数是离散随机变量在各特定取值上的概率
    * PDF:概率密度函数是一个描述这个随机变量的输出值，在某个确定的取值点附近的可能性的函数
    * CDF(cumulative distribution function):累积分布函数又叫分布函数，是概率密度函数的积分，能完整描述一个实随机变量X的概率分布
    * 密度图可视化是通过绘制数据的概率分布适当的连续曲线
      * ![](/data_mining_5.png)
  
#### 集中趋势的度量 Measures of central tendency
  * 平均值mean(sample):
    * $$\hat\mu=\frac{1}{n-1}\displaystyle\sum_{i=1}^nx_i$$
  * 平均值是否稳健robust(或稳定stable)
    * 我们将稳健型定义为不受极值影响
    * 通常来说，平均值并不是稳健的
    * 一个稳健的度量是修剪平均值trimmed mean，它发生在两边的极值被丢弃后
  * 对随机变量r.v random variable的期望(与平均值有关，但概念上不同)
    * 平均数（均值）是一个统计学的概念；期望是一个概率论的概念
    * 平均数是实验后根据实际结果统计得到的样本的平均值；期望是实验前根据概率分布“预测”的样本平均值
    * 之所以说是预测是因为 在实验前能得到的期望与实际实验得到的样本的平均数总会不可避免的存在偏差，毕竟随机实验的结果永远充满着不确定性
    * 如果我们能进行无穷次随机实验并计算出其样本的平均数的话，那么这个平均数其实就是期望.但是实验样本的平均数会随着实验样本的增多越来越接近期望，就像频率随着实验样本的增多会越来越接近概率一样
    * $$E[X]=\displaystyle\sum_{i=1}^kx_ip_i=x_1p_1+x_2p_2+...+x_kp_k$$
      * 离散型随机变量的一切可能的取值，与对应的概率乘积之和
  * 期望的属性
    * $$E[X+Y]=E[X]+E[Y]$$ 期望的线性 X与Y的期望和等于两个期望分开计算后和
    * $$E[aX]=aE[X]$$ a是个常量
    * $$E[XY]=E[X]\cdot{E[Y]}$$ X和Y是独立的
    * $$E[E[X]]=E[X]$$
  * 例子:骰子有6面，掷到每一面的概率相同，都是六分之一
    * 平均值:3.5
    * 期望值:如果投掷的次数够多，期望值就越接近平均值即3.5

  * 中位数median(sample)
    * $$P(X\leq{m})\geq{\frac{1}{2}}\text{\,{and}\,}P(X\geq{m})\geq{\frac{1}{2}}$$
    * 中位数是否robust(或稳定stable)
      * 是的
        * 不受极端值影响
        * 取的是随机变量中的实际值

  * 众数mode(sample)
    * 在随机变量中出现最多的值
    * 在剧中趋势的度量中可能用不到
    * $$mode(X)=arg\,{max}\,\hat{f}(x)$$
    $$\hat{f}(x)=P(X=x)=\frac{1}{n}\displaystyle\sum_{i=1}^nI(x_i=x)$$
    where
    $$I(x_i=x)=\begin{cases}
        1 &if\,x_i=x\\
        0 &if\,x_i\neq{x}
    \end{cases}$$
    * ![](/data_mining_6.png)

  * 离散程度描述:方差variance和标准差standard deviation
    * 方差:衡量随机变量或一组数据时离散程度的度量，概率论中方差用来度量随机变量和其数学期望(即均值)之间的偏离程度
    * 样本方差公式:$$var(X)=\sigma^2=\frac{1}{n-1}\displaystyle\sum_{i=1}^n(x_i-\hat\mu)^2$$
    * 样本标准差:样本方差的开方
    * 样本标准差公式:$$\sigma=\sqrt{\frac{1}{n-1}\displaystyle\sum_{i=1}^n(x_i-\hat\mu)^2}$$

  * 并不仅仅只有标准差
    * 最大偏差Maximal deviation:$$maxdev(X)=max(|x_i-\mu|)\forall{x_i}\in{X}$$
    * 平均离差Mean absolute deviation:$$mad(X)=\frac{1}{n}\displaystyle\sum_{i=1}^n|x_i-\mu|.\forall{x_i}\in{X}$$
    * ![](/data_mining_7.png)

  * 同样我们会考虑双变量分析，试图理解双变量$x_1$与$x_2$的关系，通常我们可以将向量看作是一个2D空间
    * 标量Scalar:标量只有大小概念，没有方向的概念，通过一个具体的数值就能表达完整.
      * 重量、温度、长度、提及、时间、热量等都数据标量
    * 向量Vector:物理学上也叫矢量，指由大小和方向共同决定的量(跟「标量」相区别).如力、速度等.向量主要有2个维度：大小、方向
    * 矩阵Matrix:矩阵（Matrix）是一个按照长方阵列排列的复数或实数集合，元素是实数的矩阵称为实矩阵，元素是复数的矩阵称为复矩阵.而行数与列数都等于n的矩阵称为n阶矩阵或n阶方阵.由m × n个数排成的m行n列的数表称为m行n列的矩阵，简称m × n矩阵
    * 张量Tensor:实际上就是一个多维数组(multidimensional array)，其目的是能够创造更高维度的矩阵、向量，其具有3个属性
      * 维度rank:number of dimensions
      * 行列数shape:number of rows and columns
      * 元素类型type:data type of tensor's elements
    * ![](/data_mining_8.png)

  * 矩阵的一阶二阶中(平均值、方差)与之前计算一致，除非返回的不是向量
    * ![](/data_mining_9.png)
    * 每个属性的方差分布计算，$\sigma{_1^2}$代表$X_1$，$\sigma{_2^2}$代表$X_2$
    * 总方差$var(D)=\sigma{_1^2}+\sigma{_2^2}$
  * 关联度度量:协方差Covariance
    * 协方差在概率论和统计学中用于衡量两个变量的总体误差。而方差是协方差的一种特殊情况，即当两个变量是相同的情况.协方差表示的是两个变量的总体的误差，这与只表示一个变量误差的方差不同.如果两个变量的变化趋势一致，也就是说如果其中一个大于自身的期望值，另外一个也大于自身的期望值，那么两个变量之间的协方差就是正值.如果两个变量的变化趋势相反，即其中一个大于自身的期望值，另外一个却小于自身的期望值，那么两个变量之间的协方差就是负值.
    * 公式:$cov(X_1, X_2)=\hat{\sigma}_1{_2}=\frac{1}{n-1}\displaystyle\sum_{i=1}^n(x_i{_1}-\hat\mu)(x_i{_2}-\hat\mu_2)$
    * 对于有两属性的方差协方差variance-covariance可以表示成如下:
      * $\hat\sum=\begin{pmatrix}
        \hat\sigma{_1^2} & \hat\sigma{_1}_2 \\
        \hat\sigma{_1}_2 & \hat\sigma{_2^2}
        \end{pmatrix}$
      * 正方形
      * 对称性
      * 对角线上的元素为各个随机变量的方差，非对角线上的元素为两两随机变量之间的协方差
      * 总方差为对角线的值和，通常以$\sum$表示
      * ![](/data_mining_10.png)
  * 与协方差有关系的是相关
    * ![](/data_mining_11.png)
  * 为什么既有协方差又有相关性
    * 协方差的值范围是:[$-\infty,\infty$]
    * 相关性的范围是:[-1,1]
    * 相关性是无量纲，它只是变量之间关系的无单位度量
    * 相关性并不代表因果关系
    * ![](/data_mining_12.png)

  * 相关性与共线性collinearity
    * 相关性是用来度量两个变量之间的关系
    * 当两个变量相关性很高时，可以通过一个来预测另一个，换句话说一个变量是另一个变量的线性组合
      * 当大于两个预测变量是相互关联