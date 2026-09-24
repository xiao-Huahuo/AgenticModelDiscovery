# LLM-SR 结构不确定性 / Structure Identifiability 论文包

## 这个包解决什么问题

本次检索严格围绕下面这个问题：

> 当多个不同的符号方程结构都能解释有限、带噪声的数据时，如何显式表示、比较、归并并最终消除“结构不确定性”？

这里刻意区分两个概念：

1. **结构不确定性 / model-structure uncertainty**：不同公式结构 `G1, G2, ...` 都能解释当前数据，希望得到 `p(G | D)`、竞争结构集合或结构 inclusion probability。
2. **传统 structural identifiability**：模型结构已经给定，讨论参数或隐状态能否从理想观测中唯一恢复。E01-E03 放在“术语边界”目录里，主要用于避免把两者混为一谈。

## 最重要的检索结论

原先“把 LLM-SR 从单一最优公式升级成多个候选公式的结构 posterior”这一想法，已经存在非常接近的前人工作，尤其是：

- **A04 HierBOSSS**：直接指出 symbolic representations are non-identifiable，并用 posterior set / Occam's window 总结多个 plausible symbolic structures。
- **A02 ERRLESS**：用最大熵强化学习学习并采样 `posterior over expressions`。
- **A03 Bayesian SR via Posterior Sampling**：用 SMC 近似多模态 symbolic-expression posterior。
- **A05 VaSST**：用 soft symbolic trees + variational inference 建立结构 posterior。
- **A01 UQ Survey**：系统整理 SR 中的 Bayesian、频率学派和 model-selection UQ。

因此，“只做 `p(G|D)`”已经很难构成足够新的核心贡献。

### 目前仍然更有空间的组合

本次检索把真正值得继续追的链条拆成了四块：

1. **结构 posterior**：A02-A06。
2. **数学等价类归并**：B01-B02。不同语法树可能是同一个数学函数，直接对语法树做 posterior 会把概率质量重复分裂。
3. **主动区分候选结构**：C01-C06。候选结构仍然分不清时，主动寻找最能让它们预测分歧的新输入、新扰动或新实验。
4. **动态系统 / 电力约束**：把上述三块放入动态负荷建模，使实验设计受到安全、物理可实施性、扰动类型和运行边界约束。

截至本次检索，尚未看到一篇论文把 **free-form/LLM symbolic proposal + semantic equivalence-class posterior + active experiment design for falsification + power-system dynamic modeling** 四部分作为一个统一闭环完成。这个组合比单纯的“结构 posterior”更值得继续验证新颖性。

## 建议阅读顺序

如果只读 8 篇：

1. A01：UQ Survey，先掌握全局。
2. A04：HierBOSSS，与你的“结构 identifiability”问题最直接。
3. A02：ERRLESS，结构 posterior + RL。
4. A03：Bayesian SR via Posterior Sampling，SMC 路线。
5. A05：VaSST，变分结构 posterior。
6. B01：EGG-SR，解决数学等价结构。
7. C01：Active Learning in GP，SR 内部主动采数据。
8. C04：Optimal experiment design for model discrimination，把“新数据”升级成“主动设计最能证伪候选结构的实验”。

然后根据研究路线补：
- 想做 Bayesian 原理：A07-A13。
- 想做动态系统：C03、D01-D06。
- 想搞清楚“structural identifiability”术语：E01-E03。

## 文件说明

- `papers_manifest.csv/json`：全部论文、类别、相关性、PDF/落地页链接。
- 各目录中的 `.webloc`：macOS 双击打开论文。
- 各目录中的 `.url`：Windows 双击打开论文。
- `下载全部.command`：macOS/Linux 一键下载所有有直接公开 PDF 地址的论文。
- `download_all.ps1`：Windows PowerShell 一键下载。
- `仅手动获取.md`：当前未找到稳定直链、需要从落地页手动获取的论文。

## 关于 ZIP 里的 PDF 本体

本次会话的网页检索工具可以读取并核验这些公开 PDF，但当前沙箱的外部二进制下载接口无法把网页 PDF 字节写入工作目录。因此这个 ZIP 是“已核验论文索引 + 一键下载器”，没有把网络 PDF 冒充成本地已下载文件。

在 macOS 上解压后运行：

```bash
chmod +x 下载全部.command
./下载全部.command
```

脚本会按本文的五个分类目录下载公开 PDF，并检查文件头是否为 PDF。
