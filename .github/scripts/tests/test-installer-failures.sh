#!/usr/bin/env bash
set -euo pipefail
: "${INSTALLER_SCRIPTS:?Set INSTALLER_SCRIPTS to PR 81 scripts}"
temp="$(mktemp -d)"
trap 'rm -rf "$temp"' EXIT
mkdir "$temp/bin"
cat > "$temp/bin/curl" <<'SH'
#!/bin/bash
echo 'curl: (22) simulated installer HTTP 503' >&2
exit 22
SH
cat > "$temp/bin/sudo" <<'SH'
#!/bin/bash
while read -r line; do :; done
exit 0
SH
chmod +x "$temp/bin/"*
status=0
PATH="$temp/bin" CINC_VERSION=26.2.4 CINC_CHANNEL=stable /bin/bash "$INSTALLER_SCRIPTS/install-unix.sh" > "$temp/log" 2>&1 || status=$?
test "$status" -eq 22
grep -q 'simulated installer HTTP 503' "$temp/log"
status=0
PATH="$temp/bin" CINC_DISTRIBUTION=workstation GITHUB_OUTPUT="$temp/output" /bin/bash "$INSTALLER_SCRIPTS/outputs-unix.sh" > "$temp/log" 2>&1 || status=$?
test "$status" -ne 0
grep -q 'Could not find cinc in PATH' "$temp/log"
test ! -s "$temp/output"
echo 'Installer failure tests passed'
