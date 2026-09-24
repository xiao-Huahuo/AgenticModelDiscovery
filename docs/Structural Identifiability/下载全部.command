#!/bin/bash
set -u
ROOT="$(cd "$(dirname "$0")" && pwd)"
OUT="$ROOT/下载的PDF"
mkdir -p "$OUT"
ok=0; fail=0

download_one() {
  id="$1"; cat="$2"; title="$3"; url="$4"
  dir="$OUT/$cat"; mkdir -p "$dir"
  safe="$(printf "%s" "${id}_${title}" | tr '/:\"?*<>|' '_________' | cut -c1-170)"
  file="$dir/${safe}.pdf"
  if [ -s "$file" ]; then echo "[SKIP] $id $title"; return; fi
  echo "[GET ] $id $title"
  if curl -fL --retry 3 --retry-delay 2 --connect-timeout 20 -A "Mozilla/5.0" "$url" -o "$file.tmp"; then
    if head -c 4 "$file.tmp" | grep -q "%PDF"; then
      mv "$file.tmp" "$file"; ok=$((ok+1)); echo "[ OK ] $id"
    else
      rm -f "$file.tmp"; fail=$((fail+1)); echo "[FAIL] $id: 返回内容不是 PDF"
    fi
  else
    rm -f "$file.tmp"; fail=$((fail+1)); echo "[FAIL] $id: 下载失败"
  fi
}

download_one "A01" "01_直接结构不确定性_FreeForm_SR" "Are you sure? A Comprehensive and Comprehensible Survey of Uncertainty Quantification in Symbolic Regression" "https://arxiv.org/pdf/2606.06567.pdf"
download_one "A02" "01_直接结构不确定性_FreeForm_SR" "Bayesian Symbolic Regression with Entropic Reinforcement Learning" "https://arxiv.org/pdf/2608.09617.pdf"
download_one "A03" "01_直接结构不确定性_FreeForm_SR" "Bayesian Symbolic Regression via Posterior Sampling" "https://arxiv.org/pdf/2512.10849.pdf"
download_one "A04" "01_直接结构不确定性_FreeForm_SR" "Probabilistic Symbolic Regression for Equation Discovery via Operator-Induced and Regularized Symbolic Forests" "https://arxiv.org/pdf/2509.19710.pdf"
download_one "A05" "01_直接结构不确定性_FreeForm_SR" "VaSST: Variational Inference for Symbolic Regression using Soft Symbolic Trees" "https://arxiv.org/pdf/2602.23561.pdf"
download_one "A06" "01_直接结构不确定性_FreeForm_SR" "Uncertainty-Aware Symbolic Regression through Bayesian Support Selection" "https://arxiv.org/pdf/2606.04042.pdf"
download_one "A07" "01_直接结构不确定性_FreeForm_SR" "Bayesian Symbolic Regression" "https://arxiv.org/pdf/1910.08892.pdf"
download_one "A08" "01_直接结构不确定性_FreeForm_SR" "A Bayesian machine scientist to aid in the solution of challenging scientific problems" "https://arxiv.org/pdf/2004.12157.pdf"
download_one "A09" "01_直接结构不确定性_FreeForm_SR" "Bayesian symbolic regression: automated equation discovery from a physicist's perspective" "https://arxiv.org/pdf/2507.19540.pdf"
download_one "A10" "01_直接结构不确定性_FreeForm_SR" "Priors for Symbolic Regression" "https://arxiv.org/pdf/2304.06333.pdf"
download_one "A11" "01_直接结构不确定性_FreeForm_SR" "Automated Learning of Interpretable Models with Quantified Uncertainty" "https://arxiv.org/pdf/2205.01626.pdf"
download_one "A12" "01_直接结构不确定性_FreeForm_SR" "Bayesian Model Selection for Reducing Bloat and Overfitting in Genetic Programming for Symbolic Regression" "https://ntrs.nasa.gov/api/citations/20220001900/downloads/smcbingo_gecco22.pdf"
download_one "A13" "01_直接结构不确定性_FreeForm_SR" "Comparing Methods for Estimating Marginal Likelihood in Symbolic Regression" "https://ntrs.nasa.gov/api/citations/20240007699/downloads/gecco_2024_final.pdf"
download_one "A15" "01_直接结构不确定性_FreeForm_SR" "GFN-SR: Symbolic Regression with Generative Flow Networks" "https://arxiv.org/pdf/2312.00396.pdf"
download_one "B01" "02_符号等价类_Equivalence" "EGG-SR: Embedding Symbolic Equivalence into Symbolic Regression via Equality Graph" "https://arxiv.org/pdf/2511.05849.pdf"
download_one "B02" "02_符号等价类_Equivalence" "Improving Genetic Programming for Symbolic Regression with Equality Graphs" "https://arxiv.org/pdf/2501.17848.pdf"
download_one "C01" "03_主动区分结构_Active_Discrimination" "Active Learning in Genetic Programming: Guiding Efficient Data Collection for Symbolic Regression" "https://arxiv.org/pdf/2308.00672.pdf"
download_one "C02" "03_主动区分结构_Active_Discrimination" "Active Learning Improves Performance on Symbolic Regression Tasks in StackGP" "https://arxiv.org/pdf/2202.04708.pdf"
download_one "C03" "03_主动区分结构_Active_Discrimination" "Ensemble-SINDy: Robust sparse model discovery in the low-data, high-noise limit, with active learning and control" "https://arxiv.org/pdf/2111.10992.pdf"
download_one "C04" "03_主动区分结构_Active_Discrimination" "Optimal experiment design for practical parameter identifiability and model discrimination" "https://arxiv.org/pdf/2506.11311.pdf"
download_one "C06" "03_主动区分结构_Active_Discrimination" "An anticipatory approach to optimal experimental design for model discrimination" "https://modeleau.fsg.ulaval.ca/fileadmin/modeleau/documents/Publications/pvr870.pdf"
download_one "D01" "04_固定字典的结构不确定性_Dictionary_Based" "Equation discovery for nonlinear dynamical systems: A Bayesian viewpoint" "https://eprints.whiterose.ac.uk/id/eprint/169192/6/mssp_20_submitted_final_proof.pdf"
download_one "D02" "04_固定字典的结构不确定性_Dictionary_Based" "On spike-and-slab priors for Bayesian equation discovery of nonlinear dynamical systems via sparse linear regression" "https://arxiv.org/pdf/2012.01937.pdf"
download_one "D03" "04_固定字典的结构不确定性_Dictionary_Based" "Sparsifying Priors for Bayesian Uncertainty Quantification in Model Discovery" "https://arxiv.org/pdf/2107.02107.pdf"
download_one "D04" "04_固定字典的结构不确定性_Dictionary_Based" "Equation Discovery with Bayesian Spike-and-Slab Priors and Efficient Kernels" "https://arxiv.org/pdf/2310.05387.pdf"
download_one "D05" "04_固定字典的结构不确定性_Dictionary_Based" "Rapid Bayesian identification of sparse nonlinear dynamics from scarce and noisy data" "https://arxiv.org/pdf/2402.15357.pdf"
download_one "D06" "04_固定字典的结构不确定性_Dictionary_Based" "Bayesian autoencoders for data-driven discovery of coordinates, governing equations and fundamental constants" "https://arxiv.org/pdf/2211.10575.pdf"
download_one "E01" "05_术语边界_Structural_Identifiability" "Comprehensive Framework for Model Discovery and Discrimination Based on Symbolic Regression and Structural Identifiability" "https://psecommunity.org/wp-content/plugins/wpor/includes/file/2606/LAPSE-2026.0381-1v1.pdf"
download_one "E02" "05_术语边界_Structural_Identifiability" "PyCC.id: A package for hypothesis-driven equation discovery with structural identifiability" "https://arxiv.org/pdf/2606.05191.pdf"
download_one "E03" "05_术语边界_Structural_Identifiability" "Incorporating Model Identifiability into Equation Discovery of ODE Systems" "https://gpbib.cs.ucl.ac.uk/gecco2008/docs/p2135.pdf"

echo ""
echo "完成：成功 $ok，失败 $fail。失败项可查看 papers_manifest.csv 中的 landing 页面手动获取。"
