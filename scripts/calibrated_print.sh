#!/usr/bin/env bash
# calibrated_print.sh <file.pdf> [lp options...]
#
# Env:
#   SX, SY       extra scaling
#   CAL_SX/CAL_SY  override the current printer calibration since it is currently the metrics from my printer
#   PRINTER      queue name
#   KEEP=1       keep the intermediate PDF and print its path

set -euo pipefail

CAL_SX=${CAL_SX:-0.9950}
CAL_SY=${CAL_SY:-0.9842}
USX=${SX:-1}
USY=${SY:-1}
PRINTER=${PRINTER:-Brother_HL_B2180DW}

[[ $# -ge 1 ]] || { echo "usage: printcal <file.pdf> [lp options...]" >&2; exit 1; }
src=$1; shift
[[ -r $src ]] || { echo "printcal: cannot read $src" >&2; exit 1; }


TW=595.276; TH=841.890
TCX=$(bc -l <<< "$TW/2"); TCY=$(bc -l <<< "$TH/2")


read -r SW SH < <(pdfinfo "$src" | awk '/^Page size:/{print $3, $5}')
SCX=$(bc -l <<< "$SW/2"); SCY=$(bc -l <<< "$SH/2")


FX=$(bc -l <<< "$USX * $CAL_SX")
FY=$(bc -l <<< "$USY * $CAL_SY")

tmp=$(mktemp --suffix=.pdf)
[[ -n ${KEEP:-} ]] || trap 'rm -f "$tmp"' EXIT

gs -q -o "$tmp" -sDEVICE=pdfwrite \
   -dFIXEDMEDIA -dDEVICEWIDTHPOINTS=596 -dDEVICEHEIGHTPOINTS=842 \
   -c "<</Install {$TCX $TCY translate $FX $FY scale -$SCX -$SCY translate}>> setpagedevice" \
   -f "$src"

printf 'printcal: %s  scale %.5f x %.5f\n' "$(basename "$src")" "$FX" "$FY" >&2
lp -d "$PRINTER" -o media=A4 -o print-scaling=none "$@" "$tmp"
[[ -n ${KEEP:-} ]] && echo "kept: $tmp" >&2
