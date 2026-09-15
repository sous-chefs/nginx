#!/usr/bin/env bash
set -euo pipefail
python3 - <<'PY'
import json, os, pathlib
root = pathlib.Path(os.environ['RUNNER_TEMP']) / 'trial-times'
def elapsed(stage):
    start, end = root / (stage + '-start'), root / (stage + '-end')
    return round(float(end.read_text()) - float(start.read_text()), 3) if start.exists() and end.exists() else None
result = {key: os.environ.get(env) for key, env in {
    'variant': 'TRIAL_VARIANT', 'repeat': 'TRIAL_REPEAT', 'suite': 'SUITE', 'os': 'OS',
    'status': 'TRIAL_STATUS', 'install_status': 'INSTALL_STATUS',
    'image_os': 'ImageOS', 'image_version': 'ImageVersion', 'run_id': 'GITHUB_RUN_ID',
    'run_attempt': 'GITHUB_RUN_ATTEMPT', 'harness_sha': 'GITHUB_SHA',
}.items()}
result.update(install_seconds=elapsed('install'), kitchen_seconds=elapsed('kitchen'))
pathlib.Path('trial-result.json').write_text(json.dumps(result, indent=2) + '\n')
print(json.dumps(result, indent=2))
with open(os.environ['GITHUB_STEP_SUMMARY'], 'a') as summary:
    summary.write('```json\n' + json.dumps(result, indent=2) + '\n```\n')
PY
