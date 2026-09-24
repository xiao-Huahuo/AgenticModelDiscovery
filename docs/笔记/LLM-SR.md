## LLM-SR：Scientific Equation Discovery via Programming with Large Language Models
### 任务
符号回归(Symbolic Regression,SR): 
真实世界存在一个未知关系：$y=f(x_1,x_2,\ldots,x_d)$
研究者拥有一批观测数据：$D=\{(x_i,y_i)\}$
任务是从数据中恢复一个具有可解释性的数学表达式$\tilde f$，使它既能够拟合已有数据，也能够推广到训练范围之外的数据。(反过来从数据找到方程)
优化目标: $$G∗=\arg \max_G​ Score(f(x;θ_G^∗​,G),D)$$其中：$\theta_G^* = \arg\min_{\theta} MSE \left( f(\mathbf x;\theta,G), y \right)$
### 痛点
传统解法: 使用表达式树、遗传规划、预定义算子集合等方式，在巨大组合空间中搜索公式,排列组合.
### 解决方案
科学方程 --> 可执行程序
##### 搜索过程与结构
- 搜索器(LLM): 生成带待定系数的“方程骨架”
	猜测方程结构, 猜测科学上合理的变量关系, 写成可执行程序
- 数值优化器(传统优化算法,包括BFGS/Adam): 求连续参数, 拟合结果反馈给搜索过程, 表现较好的历史方程进入经验池
- 经验池(Experience Buffer): 作为上下文指导下一轮LLM生成
- 数据评价器: 评估方程效果
将问题拆成两部分: 
- 结构空间$G$(离散的、组合爆炸的结构问题,LLM负责)
- 参数空间$\theta$(连续参数问题, 优化器负责)

##### 生成内容的改进
传统符号回归: 传统符号回归通常把公式存成一棵**表达式树**
新解法: 搜索一段**Python程序**
	优势: LLM擅长程序; 程序的表达能力比表达式树强.

### 具体设计
#### LLM搜索算法
##### 上下文
Prompt包含信息:
1. 任务指令: "补全下面的方程函数，根据变量的物理意义寻找合理关系。"
2. 科学问题描述: 参数含义,目标,研究对象
3. 评价机制与参数优化机制
4. 经验池: 之前已经发现的优秀方程
每次调用会让 LLM 采样多个候选方程.迭代式 LLM 引导搜索闭环具备Agent-like特征.
##### 搜索算法
论文 Algorithm 1 可以概括为：

$$\mathcal P_0 \rightarrow SampleExperience \rightarrow Prompt \rightarrow LLM \rightarrow \mathcal F_t \rightarrow Optimize \rightarrow Score \rightarrow UpdatePopulation$$

循环 T 次。
每轮从经验池采样 k 个例子，构建 few-shot prompt；
LLM 生成 b 个候选；
候选执行并完成 continuous parameter fitting；
评分后，高质量候选写回 experience buffer。最终返回搜索期间发现的最佳方程程序及其分数.
##### 参数优化
实验: 
	一种是 `NumPy + BFGS`。BFGS 属于经典非线性数值优化算法，比较适合参数数量有限的问题。
	另一种是 `PyTorch + Adam`。方程程序保持可微以后，可以直接利用自动微分求参数。
评价: $y^​=f(x;θ^∗)$,再计算预测结果与真实数据之间的均方误差 MSE,最终$Score=-MSE$,误差越小,$Score$越大.
结果:
	BFGS 略占优势,主要原因是当时的 LLM 更擅长生成 NumPy 程序.
##### 经验池 Experience Management

论文采用 **multi-island，多岛模型**维护搜索经验。每个 island 独立保存一组历史候选方程及其分数：

$$\mathcal I_j=\{(f_i,s_i)\}$$

其中 $f_i$ 是候选程序，$s_i$是评价分数。不同 island 独立演化，从而维持搜索方向的多样性。约每 4 小时淘汰表现较差的一半 island，并用优秀 island 中的高质量候选重新初始化。

在单个 island 内，候选按 score 聚成多个 cluster。选择下一轮参考经验时，先用 **Boltzmann sampling** 偏向高分 cluster：

$$P(C_j)= \frac{\exp(S_j/\tau)} {\sum_k \exp(S_k/\tau)}$$

选中 cluster 后，再偏向其中较短的程序：

$$P(f_i\mid C_j)\propto \exp(-l_i/\tau_p)$$

每轮通常抽取两个历史候选放入 Prompt，LLM 在这些经验基础上生成新的方程骨架。新候选经过参数优化和评分后重新写入经验池，形成：

$\text{经验池} \rightarrow \text{采样历史候选} \rightarrow \text{LLM生成} \rightarrow \text{参数优化与评分} \rightarrow \text{更新经验池}$

核心作用是同时保留**高质量经验**和**结构多样性**，减少搜索过早收敛。




### 实验
##### Baseline与Backbone
**Baseline**:
	**GPlearn** 经典遗传编程
	**PySR** 多岛进化符号回归方法
	**DSR** 强化学习生成符号表达式
	**uDSR** 在 DSR 的基础上加入更多搜索机制
	**NeSymReS 和 E2E** 预训练 Transformer 型符号回归
- Baseline 允许运行超过 **200 万次迭代/搜索评估级别**，并进行了 5 次重复实验；
- LLM-SR 主实验大约只搜索 **2500 轮**，每次 Prompt 生成 4 个候选。
**Backbone Model**: 主实验采用**GPT-3.5-turbo**和**Mixtral-8×7B**,附录测试了**GPT-4o**.
##### 数据集选择
没有采用Feynman数据集当做主实验.
证据: 
1. Perplexity: Feynman equation generation 的 perplexity 明显低于作者设计的新问题，说明 LLM 对这些经典表达式具有更高确定性。
$$PPL = \exp \left( -\frac{1}{N} \sum_{i=1}^{N} \log p(x_i|x_{<i}) \right)$$
2. Discovery Trajectory: LLM-SR 在许多 Feynman 问题上仅需极少迭代便恢复近乎准确表达式，有些甚至接近 single-pass recovery。这说明LLM大多在语料中已经训练进模型,很难判断发生了Scientific Discovery还是Formula Recitation.
##### 1和2: 非线性振子 (可行性试验)
第一个：

$$\dot v = F\sin(\omega x) -\alpha v^3 -\beta x^3 -\gamma xv -x\cos(x)$$

第二个：

$$v˙=Fsin(ωt)−αv3−βxv−δxexp(γx)$$
测试标准:
- 能否恢复复杂结构
- 是否可以缩小搜索空间
- 能否 OOD
实验发现，LLM 很早就会形成类似“driving force”“damping”“restoring force”的结构，再逐渐通过数据反馈修改它们具体的数学表达式。传统符号回归看到的主要是一组变量和数值，因此更容易得到数值拟合尚可、物理意义却比较杂乱的表达式。
##### 3. 大肠杆菌生长 (领域知识是否有用)
首先提示LLM: 生长率与四类东西有关,包括 细菌密度B,底物浓度S,温度T,pH值.
实验保留了一部分经典知识,底物使用Monod结构:$$\frac{S}{K_S+S}$$​重设计温度和pH部分:
真实生成方程为：
$$\frac{dB}{dt} = \mu_{\max}B \left(\frac{S}{K_s+S}\right) \frac{\tanh(k(T-x_0))} {1+c(T-x_{\mathrm{decay}})^4} \exp(-|pH-pH_{\mathrm{opt}}|) \sin^2 \left( \frac{(pH-pH_{\min})\pi} {pH_{\max}-pH_{\min}} \right)$$
实验发现,LLM主要修改温度和 pH 的非线性形式，而相对稳定地保留 Monod 项。论文认为这体现了领域先验对搜索方向的帮助。
##### 4. 铝合金应力应变 (没有真公式时的经验建模)
铝合金的材料曲线会随温度经历多个阶段的变化,其数学关系呈现明显非线性甚至近似分段形式.
实验目标: "发现一个既拟合实验数据，又具有合理结构，而且能推广到没参与训练的温度条件的经验公式"
实验发现LLM可以写出`if strain < threshold: ... else ...`的结构,在可微参数优化上又可以把 `if` 换成 sigmoid 等平滑函数.
##### 实验结果
equation-space exploration efficiency,在更少的搜索次数中出现更多接近答案的leap,大幅压缩了假设空间.

消融实验结果: 按影响因素从高到低排序
1. Skeleton + Numerical : $\theta$也写出来,取消优化器: 性能极差,甚至退化 
2. Iterative Refinement : 去掉迭代反馈, 去Agent化: 性能极差
3. Scientific Prior : 去掉科学背景: 性能下降
4. Program Representation : 去掉程序,换成数学公式: 性能下降
5. Multi-island Experience : 去掉多岛: 多样性降低,过早收敛
6. Backbone : 换更强LLM: 性能上升,说明LLM-SR是一个框架.

##### 鲁棒性
给 Oscillation 2 加入$\sigma= 0,\ 0.01,\ 0.05,\ 0.1$的 Gaussian noise，然后比较 LLM-SR 和 PySR.
结果: 随着噪声增加，两种方法性能都下降，但 LLM-SR 在中等噪声情况下依然保持明显更好的性能，尤其是 OOD。作者将其解释为科学先验在数据质量下降时提供了额外约束。

### 限制
1. LLM-SR 的能力和基础模型训练数据密切相关。某个科学领域在预训练语料里覆盖不足，或者知识存在偏差，proposal quality 会受到影响。
2. 反复调用 LLM，还要对每个 skeleton 做参数优化，因此大规模问题的计算成本会比较高.
	未来方向: RAG,领域专用语言模型,hunman expert in the loop;更严格的benchmark.
3. 可辨识性(Identifiability)难题: 从有限数据出发,两个完全不同的公式可能产生几乎一致的结果.在实验2中出现如下结果:
	- Oscillation 2 里真实方程含有：$-5xe^{0.5x}$
	- LLM-SR 找到类似：$5(1-e^x)$
	两者公式不同,但对于自变量区域,两者结果几乎一致.这说明低MSE不代表找到了真实结构.
4. Benchmark不足: 使用MSE不足以呈现公式的结构合理性,系统里缺少非常强的外部物理 verifier.
	后续可以加入: 
		量纲一致性
		守恒律
		稳定性
		单调性
		边界条件
		passivity
		causality










