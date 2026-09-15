#!/usr/bin/env bash
set -euo pipefail

: "${OS:?Set OS to the Kitchen platform}"
: "${TRIAL_SCRIPTS:?Set TRIAL_SCRIPTS to the trial scripts directory}"
echo "runner_image=${ImageOS:-unknown} version=${ImageVersion:-unknown}"
uname -a
for tool in cinc chef knife kitchen; do
  command -v "$tool"
  "$tool" --version
done

# Dokken constructs chef_image:chef_version. Pull by digest, then give the
# local image a fixed tag and disable subsequent pulls in the trial config.
python3 - "$TRIAL_SCRIPTS/ci-image-pins.json" <<'PY'
import json, os, subprocess, sys
pins = json.load(open(sys.argv[1]))
platform = {'ubuntu-2204': 'ubuntu-22.04', 'ubuntu-2404': 'ubuntu-24.04'}.get(os.environ['OS'], os.environ['OS'])
for source, target in [('cincproject/cinc', 'ci-trial/cinc:pinned'), ('dokken/' + platform, 'ci-trial/platform:pinned')]:
    print(f'{source}={pins[source]}', flush=True)
    subprocess.run(['docker', 'pull', pins[source]], check=True)
    subprocess.run(['docker', 'tag', pins[source], target], check=True)
    subprocess.run(['docker', 'image', 'inspect', target, '--format', '{{.Id}}'], check=True)
PY

ruby_bin=/opt/cinc-workstation/embedded/bin/ruby
"$ruby_bin" -rerb -ryaml -e '
  config = YAML.load(ERB.new(File.read("kitchen.dokken.yml")).result)
  config["driver"].merge!({"chef_image" => "ci-trial/cinc", "chef_version" => "pinned", "pull_chef_image" => false, "pull_platform_image" => false})
  platform = {"ubuntu-2204" => "ubuntu-22.04", "ubuntu-2404" => "ubuntu-24.04"}.fetch(ENV.fetch("OS"), ENV.fetch("OS"))
  config["platforms"].select! { |entry| entry["name"] == platform }
  abort "Unknown platform: #{platform}" unless config["platforms"].length == 1
  config["platforms"].first["driver"]["image"] = "ci-trial/platform:pinned"
  File.write("kitchen.trial.yml", YAML.dump(config))
'
cat kitchen.trial.yml
kitchen list
