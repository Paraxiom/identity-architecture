#!/usr/bin/env bash
# Build the Identity-Architecture treatise to PDF (xelatex).
# Output: build/main.pdf
#
# Usage:  ./build.sh           # incremental
#         ./build.sh clean     # clean rebuild

set -uo pipefail
cd "$(dirname "$0")"

if [ "${1:-}" = "clean" ]; then
  rm -rf build
fi
mkdir -p build

# Three passes: pdf output, TOC + theorem numbering, cross-refs settle
xelatex -interaction=nonstopmode -file-line-error -output-directory=build main.tex >/dev/null
xelatex -interaction=nonstopmode -file-line-error -output-directory=build main.tex >/dev/null
xelatex -interaction=nonstopmode -file-line-error -output-directory=build main.tex >/dev/null

if [ ! -f build/main.pdf ]; then
  echo "BUILD FAILED — see build/main.log"
  exit 1
fi

undefined=$(grep -E "Citation.*undefined|Reference.*undefined" build/main.log 2>/dev/null | wc -l | tr -d ' ')
if [ "${undefined:-0}" -gt 0 ]; then
  echo "WARNING: $undefined unresolved citations/references — see build/main.log"
fi

pages=$(pdfinfo build/main.pdf 2>/dev/null | awk '/^Pages:/ {print $2}')
size=$(ls -lh build/main.pdf | awk '{print $5}')
echo "Built: $(pwd)/build/main.pdf  (${pages:-?} pages, ${size}, $undefined unresolved)"
