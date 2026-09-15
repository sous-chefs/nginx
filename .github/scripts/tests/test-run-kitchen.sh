#!/usr/bin/env bash
set -euo pipefail
scripts="$(cd "$(dirname "$0")/.." && pwd)"
temp="$(mktemp -d)"
trap 'rm -rf "$temp"' EXIT
mkdir "$temp/bin"
cat > "$temp/bin/kitchen" <<'SH'
#!/bin/bash
if [[ "$1" == --version ]]; then
  echo 'Test Kitchen fake'
else
  printf '%s\n' "$@" > "$CALLS"
  exit "${KITCHEN_EXIT:-0}"
fi
SH
chmod +x "$temp/bin/kitchen"
export CALLS="$temp/calls" SUITE=distro OS=ubuntu-2404
PATH="$temp/bin:$PATH" bash "$scripts/run-kitchen.sh" > "$temp/log"
printf 'test\ndistro-ubuntu-2404\n' > "$temp/expected"
diff -u "$temp/expected" "$CALLS"
grep -q 'Running: kitchen test distro-ubuntu-2404' "$temp/log"
grep -q 'Test Kitchen fake' "$temp/log"
status=0
PATH="$temp/bin:$PATH" KITCHEN_EXIT=42 bash "$scripts/run-kitchen.sh" > "$temp/log" || status=$?
test "$status" -eq 42
grep -q '::endgroup::' "$temp/log"
rm "$temp/bin/kitchen"
status=0
PATH="$temp/bin" /bin/bash "$scripts/run-kitchen.sh" > "$temp/log" 2>&1 || status=$?
test "$status" -ne 0
grep -q 'Could not find kitchen in PATH' "$temp/log"
echo 'Kitchen shell tests passed'
