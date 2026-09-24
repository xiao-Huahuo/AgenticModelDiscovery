## Reinforcement Learning Based Symbolic Regression for Load Modeling
### 任务
符号回归问题（SR），在[LLM-SR](LLM-SR#任务)中提到。
### 痛点
传统符号回归主要依赖遗传算法等方法，但搜索效率较低，而且容易生成很复杂的表达式。
后来研究者把 RNN、Transformer 和策略梯度引入符号回归，提高表达式搜索效率。不过生成的公式仍然容易过于复杂。

### 解决方案
表达式树：预先**固定树的深度和结构**，节点在一元运算符和二元运算符之间交替。Actor只搜索节点上的运算符，因此避免在无限大的公式空间里直接搜索。
Actor（公式结构生成器）：一个PolicyNet,给节点给出每个运算符的概率，按照概率抽一个。
	**注: 论文没有写Actor内部是如何设计的,是什么网络,如何计算,仿佛是个黑箱.**
Critic（调参器）：用 MSE+梯度下降 去调整参数。
RL : Policy Gradient + Risk-Seeking Policy Gradient: 强化学习,使更好的公式(RMSE更小)更容易生成.
Candidate Pool: 候选池,动态筛选维护C个当前最好的公式,最后进行精调(选择MSE最小的).
### 具体设计
#### Critic
Actor 生成运算符序列 \(a\) 后，表达式树写成：

$$ T_w(x,a) $$

其中 \(a\) 表示公式结构，\(w\) 表示公式里的系数和偏置。

Critic 首先计算：

$$ M(X,a) = \frac{1}{n} \sum_{i=1}^{n} \left(y_i-T_w(x_i,a)\right)^2 \tag{3} $$

然后用梯度下降优化 \(w\)。

当一个 batch 中有 \(N\) 个 Actor 生成的公式时，论文写成：

$$ L(w) = \frac{1}{Nn} \sum_{i=1}^{N} \sum_{j=1}^{n} \left(y_j-T_w(x_j,a_i)\right)^2 \tag{4} $$


#### 强化学习机制
对于Actor生成并经过Critic参数优化的公式$f_n(x)$,首先计算RMSE：

$$RMSE = \sqrt{ \frac1n \sum_{i=1}^{n} (y_i-f(X_i))^2 }$$
RMSE 越小，公式越准。但强化学习喜欢“奖励越大越好”，于是作者把 RMSE 转换成：
$$R(a) = \frac{1}{1+RMSE} \tag{11}$$
RL的任务： 公式越准，奖励越高。


##### Policy Gradient

Actor希望提高高质量公式再次生成的概率。**奖励越高的公式，对应结构的生成概率越容易提高**。标准策略梯度目标为：

$$
J(\theta)=\mathbb E_{a\sim\pi_\theta}[R(a)]
$$

$$
\nabla_\theta J(\theta)
=
\mathbb E[
R(a)\nabla_\theta\log\pi_\theta(a)
]
$$


##### Risk-Seeking Policy Gradient
强化学习重点学习最优秀的一批公式,为了实现"**奖励越高,Actor更容易生成**", 标准策略梯度写成：

$$J_{\text{risk}}(\theta;\epsilon) = \mathbb E [ R(a) \mid R(a)\ge R_\epsilon(\theta) ] $$实际训练时梯度是 Monte Carlo batch 版本：

$$ \nabla_\theta J_{\text{risk}} \approx \frac1N \sum_{i=1}^{N} [ (R(a^{(i)})-\hat R_\epsilon(\theta)) \nabla_\theta\log\pi_\theta(a^{(i)}) I_{R(a^{(i)})\ge\hat R_\epsilon(\theta)} ] \tag{10} $$

其中$\hat R_\epsilon(\theta)$是当前 batch 奖励的经验分位数。
指示函数:

$$ I_{R(a^{(i)})\ge\hat R_\epsilon(\theta)} $$

根据当前 batch 的奖励计算 $1-\epsilon$分位数 $\hat R_\epsilon$，只有奖励超过阈值的公式参与 Actor 更新。这样训练重点从“提高平均公式质量”变成“提高高质量公式出现的概率”。
#### Candidate Pool
训练过程反复将当前最好的公式保存进候选池,并替换掉较差的池中公式.
Actor-Critic 搜索全部结束以后，再把这几条公式拿出来,对每一条公式的系数进行更加充分的梯度下降优化,最后找到误差最小的公式(精调)。

### 实验
##### 选型
数据集采用: 修改后的 IEEE 39 母线系统和 33 节点馈线模型。
##### 完整训练流程

每轮训练：

1. Actor一次采样 \(N\) 个运算符序列；
2. 将运算符填入固定表达式树，生成 \(N\) 个公式；
3. 对每个公式使用MSE和梯度下降优化参数；
4. 根据优化后的RMSE计算奖励 \(R(a)\)；
5. 更新Candidate Pool；
6. 使用Risk-Seeking Policy Gradient更新Actor；
7. 重复上述过程。

Actor训练结束后，对Candidate Pool中的公式进行更充分的参数微调，最后输出MSE最低的公式。

##### 实验结果
Risk-Seeking参数的$\epsilon=0.5$最好,优于0.3和0.7;
表达式树深度$L=5$最好,优于3和7.
本文方法和ANN,ZIP,Polynomial比较预测误差,本文方法整体具有较低 RMSE.







