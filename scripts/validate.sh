#!/usr/bin/env bash
# Validate a generated artifact: no network calls, no PII writes, line cap, viewport meta.
# Usage: scripts/validate.sh <artifact.html>
set -euo pipefail

FILE="${1:?artifact path required}"
fail=0

grep -E '<script[^>]+src="https?://' "$FILE" && { echo "FAIL: external script src"; fail=1; }
grep -E '\bfetch\(|XMLHttpRequest' "$FILE" && { echo "FAIL: network call"; fail=1; }
grep -Eq 'localStorage\.setItem' "$FILE" && echo "WARN: localStorage write — verify no PII"
grep -Eq '<meta[^>]+viewport' "$FILE" || { echo "FAIL: missing viewport meta"; fail=1; }

lines=$(wc -l < "$FILE")
[[ $lines -gt 500 ]] && { echo "FAIL: $lines lines (cap 500)"; fail=1; }

[[ $fail -eq 0 ]] && echo "OK: $FILE ($lines lines)"
exit $fail
