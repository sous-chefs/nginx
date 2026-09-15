#!/usr/bin/env bash
set -euo pipefail

python3 - <<'PY'
import json, os, shutil, subprocess
outputs = json.loads(os.environ['INSTALL_OUTPUTS'])
print(json.dumps(outputs, indent=2))
expected = {'distribution': 'workstation', 'requested_version': '26.2.4', 'channel': 'stable', 'runner_os': 'Linux', 'runner_arch': 'X64'}
for key, value in expected.items():
    assert outputs.get(key) == value, (key, outputs.get(key), value)
for key, tool in [('cinc_path', 'cinc'), ('chef_path', 'chef'), ('knife_path', 'knife')]:
    assert outputs.get(key) == shutil.which(tool), (key, outputs.get(key))
    assert outputs.get(key), key
assert outputs['executable_path'] == shutil.which(outputs['executable'])
version = subprocess.check_output([outputs['executable_path'], '--version'], text=True, stderr=subprocess.STDOUT)
assert outputs['version'] in version, (outputs['version'], version)
assert '26.2.4' in version, version
assert shutil.which('kitchen'), 'Kitchen unavailable in a subsequent step'
PY
