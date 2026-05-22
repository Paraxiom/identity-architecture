#!/usr/bin/env bash
# Build the Identity-Architecture treatise to PDF (xelatex).
#
# Outputs:
#   build/main.pdf         — internal build (includes §14 Implementation roadmap)
#   build/main-zenodo.pdf  — publication build (omits §14)
#
# Usage:  ./build.sh                # incremental, builds both
#         ./build.sh clean          # clean rebuild
#         ./build.sh internal       # internal only
#         ./build.sh publish        # publication only

set -uo pipefail
cd "$(dirname "$0")"

mode="${1:-both}"
if [ "$mode" = "clean" ]; then
  rm -rf build
  mode="both"
fi
mkdir -p build

run_xelatex() {
  local jobname="$1"
  local prefix="$2"
  for _ in 1 2 3; do
    xelatex -interaction=nonstopmode -file-line-error \
            -output-directory=build \
            -jobname="$jobname" \
            "${prefix}\input{main}" >/dev/null
  done
}

report() {
  local pdf="$1"
  local logf="$2"
  if [ ! -f "$pdf" ]; then
    echo "BUILD FAILED — see $logf"
    return 1
  fi
  local undefined
  undefined=$(grep -E "Citation.*undefined|Reference.*undefined" "$logf" 2>/dev/null | wc -l | tr -d ' ')
  local pages size
  pages=$(pdfinfo "$pdf" 2>/dev/null | awk '/^Pages:/ {print $2}')
  size=$(ls -lh "$pdf" | awk '{print $5}')
  echo "Built: $(pwd)/$pdf  (${pages:-?} pages, ${size}, ${undefined:-0} unresolved)"
}

if [ "$mode" = "internal" ] || [ "$mode" = "both" ]; then
  run_xelatex main ""
  report build/main.pdf build/main.log
fi

if [ "$mode" = "publish" ] || [ "$mode" = "both" ]; then
  run_xelatex main-zenodo "\def\BUILDPUBLIC{}"
  report build/main-zenodo.pdf build/main-zenodo.log
fi
