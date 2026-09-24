# 最新电力负荷建模 / 动态等值 / 在线辨识文献包

检索日期：2026-09-20

共整理 **31 篇**核心或强相关论文，其中 **13 篇**提供公开 PDF 或可直接尝试的公开 PDF 地址，可用脚本一键下载。

## 文件
- `all_papers_manifest.csv`：完整清单，含年份、主题、相关性、DOI、落地页、PDF、访问状态。
- `open_access_papers.json`：公开 PDF 清单。
- `download_open_papers.ps1`：Windows PowerShell 一键下载。
- `download_open_papers.sh`：macOS / Linux 一键下载。
- `priority_reading.md`：按当前“LLM-SR + IIMM + 在线负荷建模”目标排序。

## Windows
```powershell
Set-ExecutionPolicy -Scope Process Bypass
.\download_open_papers.ps1
```

## macOS / Linux
```bash
chmod +x download_open_papers.sh
./download_open_papers.sh
```

脚本只自动下载公开 PDF 或官方公开下载地址。出版社付费或仅可申请全文的论文保留 DOI / 官方落地页，不绕过访问控制。个别期刊会临时更换 PDF 地址，失败项会写入 `failures.txt`。

## 最值得先看的 8 篇
- Reinforcement Learning Based Symbolic Regression for Load Modeling
- Symbolic Equation Modeling of Composite Loads: A KAN based Learning Approach
- Free-Form Dynamic Load Model Synthesis With Symbolic Regression Based on Sparse Dictionary Learning
- PMU measurements enabled real-time adaptive load modeling framework
- 基于动态响应特征学习的综合负荷模型构成在线辨识
- 电力系统广义负荷建模及动静参数辨识方法
- Diffusion model-based parameter estimation in dynamic power systems
- 面向新型电力系统的负荷模型研究综述
