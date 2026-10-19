#!/usr/bin/env bash
set -euo pipefail

: "${SUITE:?Set SUITE to the Kitchen suite}"
: "${OS:?Set OS to the Kitchen platform}"
instance="${SUITE}-${OS}"
echo "::group::Kitchen ${instance}"
if ! command -v kitchen; then
  echo "::error::Could not find kitchen in PATH. Check the Workstation install step." >&2
  exit 1
fi
kitchen --version
printf 'Running: kitchen test %s\n' "$instance"
trap 'echo "::endgroup::"' EXIT
kitchen test "$instance"
