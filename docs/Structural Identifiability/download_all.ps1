$ErrorActionPreference = "Continue"
$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
$Out = Join-Path $Root "下载的PDF"
New-Item -ItemType Directory -Force -Path $Out | Out-Null
$ok=0; $fail=0

function Download-One($id,$cat,$title,$url) {
  $dir = Join-Path $Out $cat; New-Item -ItemType Directory -Force -Path $dir | Out-Null
  $safe = ($id+"_"+$title) -replace '[\\/:*?"<>|]', '_'
  if ($safe.Length -gt 170) { $safe = $safe.Substring(0,170) }
  $file = Join-Path $dir ($safe+".pdf")
  if (Test-Path $file) { Write-Host "[SKIP] $id $title"; return }
  Write-Host "[GET ] $id $title"
  try {
    Invoke-WebRequest -Uri $url -OutFile ($file+".tmp") -MaximumRedirection 10 -UserAgent "Mozilla/5.0"
    $bytes = [System.IO.File]::ReadAllBytes($file+".tmp")
    if ($bytes.Length -ge 4 -and [Text.Encoding]::ASCII.GetString($bytes[0..3]) -eq "%PDF") {
      Move-Item -Force ($file+".tmp") $file; $script:ok++; Write-Host "[ OK ] $id"
    } else { Remove-Item -Force ($file+".tmp"); $script:fail++; Write-Host "[FAIL] $id: 非 PDF" }
  } catch { if (Test-Path ($file+".tmp")) { Remove-Item -Force ($file+".tmp") }; $script:fail++; Write-Host "[FAIL] $id" }
}

Download-One 'A01' '01_直接结构不确定性_FreeForm_SR' 'Are you sure? A Comprehensive and Comprehensible Survey of Uncertainty Quantification in Symbolic Regression' 'https://arxiv.org/pdf/2606.06567.pdf'
Download-One 'A02' '01_直接结构不确定性_FreeForm_SR' 'Bayesian Symbolic Regression with Entropic Reinforcement Learning' 'https://arxiv.org/pdf/2608.09617.pdf'
Download-One 'A03' '01_直接结构不确定性_FreeForm_SR' 'Bayesian Symbolic Regression via Posterior Sampling' 'https://arxiv.org/pdf/2512.10849.pdf'
Download-One 'A04' '01_直接结构不确定性_FreeForm_SR' 'Probabilistic Symbolic Regression for Equation Discovery via Operator-Induced and Regularized Symbolic Forests' 'https://arxiv.org/pdf/2509.19710.pdf'
Download-One 'A05' '01_直接结构不确定性_FreeForm_SR' 'VaSST: Variational Inference for Symbolic Regression using Soft Symbolic Trees' 'https://arxiv.org/pdf/2602.23561.pdf'
Download-One 'A06' '01_直接结构不确定性_FreeForm_SR' 'Uncertainty-Aware Symbolic Regression through Bayesian Support Selection' 'https://arxiv.org/pdf/2606.04042.pdf'
Download-One 'A07' '01_直接结构不确定性_FreeForm_SR' 'Bayesian Symbolic Regression' 'https://arxiv.org/pdf/1910.08892.pdf'
Download-One 'A08' '01_直接结构不确定性_FreeForm_SR' 'A Bayesian machine scientist to aid in the solution of challenging scientific problems' 'https://arxiv.org/pdf/2004.12157.pdf'
Download-One 'A09' '01_直接结构不确定性_FreeForm_SR' 'Bayesian symbolic regression: automated equation discovery from a physicist''s perspective' 'https://arxiv.org/pdf/2507.19540.pdf'
Download-One 'A10' '01_直接结构不确定性_FreeForm_SR' 'Priors for Symbolic Regression' 'https://arxiv.org/pdf/2304.06333.pdf'
Download-One 'A11' '01_直接结构不确定性_FreeForm_SR' 'Automated Learning of Interpretable Models with Quantified Uncertainty' 'https://arxiv.org/pdf/2205.01626.pdf'
Download-One 'A12' '01_直接结构不确定性_FreeForm_SR' 'Bayesian Model Selection for Reducing Bloat and Overfitting in Genetic Programming for Symbolic Regression' 'https://ntrs.nasa.gov/api/citations/20220001900/downloads/smcbingo_gecco22.pdf'
Download-One 'A13' '01_直接结构不确定性_FreeForm_SR' 'Comparing Methods for Estimating Marginal Likelihood in Symbolic Regression' 'https://ntrs.nasa.gov/api/citations/20240007699/downloads/gecco_2024_final.pdf'
Download-One 'A15' '01_直接结构不确定性_FreeForm_SR' 'GFN-SR: Symbolic Regression with Generative Flow Networks' 'https://arxiv.org/pdf/2312.00396.pdf'
Download-One 'B01' '02_符号等价类_Equivalence' 'EGG-SR: Embedding Symbolic Equivalence into Symbolic Regression via Equality Graph' 'https://arxiv.org/pdf/2511.05849.pdf'
Download-One 'B02' '02_符号等价类_Equivalence' 'Improving Genetic Programming for Symbolic Regression with Equality Graphs' 'https://arxiv.org/pdf/2501.17848.pdf'
Download-One 'C01' '03_主动区分结构_Active_Discrimination' 'Active Learning in Genetic Programming: Guiding Efficient Data Collection for Symbolic Regression' 'https://arxiv.org/pdf/2308.00672.pdf'
Download-One 'C02' '03_主动区分结构_Active_Discrimination' 'Active Learning Improves Performance on Symbolic Regression Tasks in StackGP' 'https://arxiv.org/pdf/2202.04708.pdf'
Download-One 'C03' '03_主动区分结构_Active_Discrimination' 'Ensemble-SINDy: Robust sparse model discovery in the low-data, high-noise limit, with active learning and control' 'https://arxiv.org/pdf/2111.10992.pdf'
Download-One 'C04' '03_主动区分结构_Active_Discrimination' 'Optimal experiment design for practical parameter identifiability and model discrimination' 'https://arxiv.org/pdf/2506.11311.pdf'
Download-One 'C06' '03_主动区分结构_Active_Discrimination' 'An anticipatory approach to optimal experimental design for model discrimination' 'https://modeleau.fsg.ulaval.ca/fileadmin/modeleau/documents/Publications/pvr870.pdf'
Download-One 'D01' '04_固定字典的结构不确定性_Dictionary_Based' 'Equation discovery for nonlinear dynamical systems: A Bayesian viewpoint' 'https://eprints.whiterose.ac.uk/id/eprint/169192/6/mssp_20_submitted_final_proof.pdf'
Download-One 'D02' '04_固定字典的结构不确定性_Dictionary_Based' 'On spike-and-slab priors for Bayesian equation discovery of nonlinear dynamical systems via sparse linear regression' 'https://arxiv.org/pdf/2012.01937.pdf'
Download-One 'D03' '04_固定字典的结构不确定性_Dictionary_Based' 'Sparsifying Priors for Bayesian Uncertainty Quantification in Model Discovery' 'https://arxiv.org/pdf/2107.02107.pdf'
Download-One 'D04' '04_固定字典的结构不确定性_Dictionary_Based' 'Equation Discovery with Bayesian Spike-and-Slab Priors and Efficient Kernels' 'https://arxiv.org/pdf/2310.05387.pdf'
Download-One 'D05' '04_固定字典的结构不确定性_Dictionary_Based' 'Rapid Bayesian identification of sparse nonlinear dynamics from scarce and noisy data' 'https://arxiv.org/pdf/2402.15357.pdf'
Download-One 'D06' '04_固定字典的结构不确定性_Dictionary_Based' 'Bayesian autoencoders for data-driven discovery of coordinates, governing equations and fundamental constants' 'https://arxiv.org/pdf/2211.10575.pdf'
Download-One 'E01' '05_术语边界_Structural_Identifiability' 'Comprehensive Framework for Model Discovery and Discrimination Based on Symbolic Regression and Structural Identifiability' 'https://psecommunity.org/wp-content/plugins/wpor/includes/file/2606/LAPSE-2026.0381-1v1.pdf'
Download-One 'E02' '05_术语边界_Structural_Identifiability' 'PyCC.id: A package for hypothesis-driven equation discovery with structural identifiability' 'https://arxiv.org/pdf/2606.05191.pdf'
Download-One 'E03' '05_术语边界_Structural_Identifiability' 'Incorporating Model Identifiability into Equation Discovery of ODE Systems' 'https://gpbib.cs.ucl.ac.uk/gecco2008/docs/p2135.pdf'

Write-Host "完成：成功 $ok，失败 $fail"
