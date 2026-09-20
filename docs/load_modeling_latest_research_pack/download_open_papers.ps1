$ErrorActionPreference = 'Continue'
$out = Join-Path $PSScriptRoot 'papers'
New-Item -ItemType Directory -Force -Path $out | Out-Null
$headers = @{ 'User-Agent' = 'Mozilla/5.0' }
$failed = @()
Write-Host '[1/13] Reinforcement Learning Based Symbolic Regression for Load Modeling'
try {
  Invoke-WebRequest -Uri 'https://arxiv.org/pdf/2503.06879' -OutFile (Join-Path $out '01_2026_Reinforcement Learning Based Symbolic Regression for Load Modeling.pdf') -Headers $headers -MaximumRedirection 10
} catch {
  $failed += 'Reinforcement Learning Based Symbolic Regression for Load Modeling'
  Write-Warning $_.Exception.Message
}
Write-Host '[2/13] Symbolic Equation Modeling of Composite Loads: A Kolmogorov-Arnold Network based Learning Approach'
try {
  Invoke-WebRequest -Uri 'https://arxiv.org/pdf/2508.19612' -OutFile (Join-Path $out '02_2025_Symbolic Equation Modeling of Composite Loads_ A Kolmogorov-Arnold Network based Learning Approach.pdf') -Headers $headers -MaximumRedirection 10
} catch {
  $failed += 'Symbolic Equation Modeling of Composite Loads: A Kolmogorov-Arnold Network based Learning Approach'
  Write-Warning $_.Exception.Message
}
Write-Host '[3/13] 基于动态响应特征学习的综合负荷模型构成在线辨识'
try {
  Invoke-WebRequest -Uri 'https://epjournal.csee.org.cn/rc-pub/front/front-article/download/153308078/lowqualitypdf/%E5%9F%BA%E4%BA%8E%E5%8A%A8%E6%80%81%E5%93%8D%E5%BA%94%E7%89%B9%E5%BE%81%E5%AD%A6%E4%B9%A0%E7%9A%84%E7%BB%BC%E5%90%88%E8%B4%9F%E8%8D%B7%E6%A8%A1%E5%9E%8B%E6%9E%84%E6%88%90%E5%9C%A8%E7%BA%BF%E8%BE%A8%E8%AF%86.pdf' -OutFile (Join-Path $out '03_2026_基于动态响应特征学习的综合负荷模型构成在线辨识.pdf') -Headers $headers -MaximumRedirection 10
} catch {
  $failed += '基于动态响应特征学习的综合负荷模型构成在线辨识'
  Write-Warning $_.Exception.Message
}
Write-Host '[4/13] Diffusion model-based parameter estimation in dynamic power systems'
try {
  Invoke-WebRequest -Uri 'https://www.nature.com/articles/s44172-026-00670-z.pdf' -OutFile (Join-Path $out '04_2026_Diffusion model-based parameter estimation in dynamic power systems.pdf') -Headers $headers -MaximumRedirection 10
} catch {
  $failed += 'Diffusion model-based parameter estimation in dynamic power systems'
  Write-Warning $_.Exception.Message
}
Write-Host '[5/13] Online modeling method for composite load model including EVs and battery storage based on measurement data'
try {
  Invoke-WebRequest -Uri 'https://www.frontiersin.org/journals/energy-research/articles/10.3389/fenrg.2024.1378067/pdf' -OutFile (Join-Path $out '05_2024_Online modeling method for composite load model including EVs and battery storage based on measurement data.pdf') -Headers $headers -MaximumRedirection 10
} catch {
  $failed += 'Online modeling method for composite load model including EVs and battery storage based on measurement data'
  Write-Warning $_.Exception.Message
}
Write-Host '[6/13] Dynamic equivalent modelling for active distributed network considering adjustable loads charging characteristics'
try {
  Invoke-WebRequest -Uri 'https://ietresearch.onlinelibrary.wiley.com/doi/pdfdirect/10.1049/gtd2.13344' -OutFile (Join-Path $out '06_2024_Dynamic equivalent modelling for active distributed network considering adjustable loads charging characteristics.pdf') -Headers $headers -MaximumRedirection 10
} catch {
  $failed += 'Dynamic equivalent modelling for active distributed network considering adjustable loads charging characteristics'
  Write-Warning $_.Exception.Message
}
Write-Host '[7/13] Dynamic Equivalence of Active Distribution Network: Multiscale and Multimodal Fusion Deep Learning Method with Automatic Parameter Tuning'
try {
  Invoke-WebRequest -Uri 'https://www.mdpi.com/2227-7390/13/19/3213/pdf?download=1' -OutFile (Join-Path $out '07_2025_Dynamic Equivalence of Active Distribution Network_ Multiscale and Multimodal Fusion Deep Learning Method with Automatic Parameter Tuni.pdf') -Headers $headers -MaximumRedirection 10
} catch {
  $failed += 'Dynamic Equivalence of Active Distribution Network: Multiscale and Multimodal Fusion Deep Learning Method with Automatic Parameter Tuning'
  Write-Warning $_.Exception.Message
}
Write-Host '[8/13] Noise Amplitude in Ambient PMU Data and its Impact on Load Models Identification'
try {
  Invoke-WebRequest -Uri 'https://latamt.ieeer9.org/index.php/transactions/article/download/8878/2449/113533' -OutFile (Join-Path $out '08_2024_Noise Amplitude in Ambient PMU Data and its Impact on Load Models Identification.pdf') -Headers $headers -MaximumRedirection 10
} catch {
  $failed += 'Noise Amplitude in Ambient PMU Data and its Impact on Load Models Identification'
  Write-Warning $_.Exception.Message
}
Write-Host '[9/13] Applications of Electrical Load Modelling in Digital Twins of Power Systems'
try {
  Invoke-WebRequest -Uri 'https://mdpi-res.com/d_attachment/energies/energies-18-00775/article_deploy/energies-18-00775.pdf' -OutFile (Join-Path $out '09_2025_Applications of Electrical Load Modelling in Digital Twins of Power Systems.pdf') -Headers $headers -MaximumRedirection 10
} catch {
  $failed += 'Applications of Electrical Load Modelling in Digital Twins of Power Systems'
  Write-Warning $_.Exception.Message
}
Write-Host '[10/13] 面向新型电力系统的负荷模型研究综述'
try {
  Invoke-WebRequest -Uri 'https://www.dlbh.net/dlbh/article/pdf/240390' -OutFile (Join-Path $out '10_2025_面向新型电力系统的负荷模型研究综述.pdf') -Headers $headers -MaximumRedirection 10
} catch {
  $failed += '面向新型电力系统的负荷模型研究综述'
  Write-Warning $_.Exception.Message
}
Write-Host '[11/13] Data Centre Model for Transient Stability Analysis of Power Systems'
try {
  Invoke-WebRequest -Uri 'https://arxiv.org/pdf/2505.16575' -OutFile (Join-Path $out '11_2026_Data Centre Model for Transient Stability Analysis of Power Systems.pdf') -Headers $headers -MaximumRedirection 10
} catch {
  $failed += 'Data Centre Model for Transient Stability Analysis of Power Systems'
  Write-Warning $_.Exception.Message
}
Write-Host '[12/13] Dynamic Load Model for Data Centers with Pattern-Consistent Calibration'
try {
  Invoke-WebRequest -Uri 'https://arxiv.org/pdf/2602.07859' -OutFile (Join-Path $out '12_2026_Dynamic Load Model for Data Centers with Pattern-Consistent Calibration.pdf') -Headers $headers -MaximumRedirection 10
} catch {
  $failed += 'Dynamic Load Model for Data Centers with Pattern-Consistent Calibration'
  Write-Warning $_.Exception.Message
}
Write-Host '[13/13] Dynamic Modeling of Data-Center Power Delivery for Power System Resonance Analysis'
try {
  Invoke-WebRequest -Uri 'https://arxiv.org/pdf/2604.06624' -OutFile (Join-Path $out '13_2026_Dynamic Modeling of Data-Center Power Delivery for Power System Resonance Analysis.pdf') -Headers $headers -MaximumRedirection 10
} catch {
  $failed += 'Dynamic Modeling of Data-Center Power Delivery for Power System Resonance Analysis'
  Write-Warning $_.Exception.Message
}
if ($failed.Count -gt 0) { $failed | Set-Content -Encoding UTF8 (Join-Path $PSScriptRoot 'failures.txt') }
Write-Host ('Done. PDF folder: ' + $out)