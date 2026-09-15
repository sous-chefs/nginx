# Workstation shell trial

This isolated workflow compares the current Cinc Workstation installer with
[PR #81](https://github.com/sous-chefs/.github/pull/81), then compares the
JavaScript Kitchen wrapper with a shell script. Existing CI is unchanged.

## Reproduce

Run `Workstation shell trial` manually on the trial branch. The initial
evidence run was triggered by a push; subsequent runs are opt-in to avoid
repeating 42 jobs when only the report changes.

The workflow runs five repetitions of each variant on fresh Ubuntu 24.04
runners, followed by the 27 existing Nginx integration combinations using
the proposed installer and shell wrapper. No workflow cache is restored.

- `current-js`: installer 9.0.0 and Kitchen wrapper 3.0.0.
- `proposed-js`: PR #81 and Kitchen wrapper 3.0.0.
- `proposed-shell`: PR #81 and `run-kitchen.sh`.
- `full-shell`: the complete existing integration matrix with shell.

Action revisions and the Nginx subject are pinned to commits in the workflow.
All runs install Cinc Workstation 26.2.4 from the stable channel.
Container digests are recorded in `.github/scripts/ci-image-pins.json`.
The preparation script pulls those digests, tags them locally and disables
Dokken image pulls. This preserves Dokken's required `image:version` format.
Both Kitchen wrappers run from the same subject checkout.

## Collect evidence

Use an empty output directory per run attempt. Replace `RUN_ID` with the run ID.

```sh
gh run download RUN_ID --repo sous-chefs/nginx --dir /tmp/nginx-trial-artifacts
gh api --paginate --slurp repos/sous-chefs/nginx/actions/runs/RUN_ID/jobs \
  > /tmp/nginx-trial-jobs.json
python3 .github/scripts/report-ci-trial.py \
  /tmp/nginx-trial-artifacts /tmp/nginx-trial-jobs.json
```

Installer and Kitchen timers surround the action invocations. Image pulls,
tool diagnostics and output validation are outside those timers, but included
in job duration. GitHub downloads all referenced actions during setup, even
when their steps are skipped, so this trial measures wrapper execution rather
than the setup saving from completely removing the JavaScript action. Job duration comes from GitHub's start and completion times,
excluding queue time. Artifacts preserve timings, resolved Kitchen configuration
and Kitchen logs, including failures. Artifact retention is 14 days.

The report retains every job and takes installer success from GitHub step
conclusions, which are authoritative over artifact metadata. Successful install timings remain usable when a
later Kitchen step fails. Failed installs do not enter successful-install
medians. Kitchen and total-job medians use successful jobs only.

## Acceptance

Compare `current-js` with `proposed-js` for installer effects, and `proposed-js`
with `proposed-shell` for wrapper effects. An increase exceeding both 10% and
five seconds in median duration requires investigation. Similar speed is
acceptable when debugging improves and all compatibility checks pass.

Require all 27 full-matrix jobs to pass before recommending adoption. Report
any additional observed failures. A small trial cannot establish long-term
reliability. Runner image revisions are recorded because the hosted runner
label itself is mutable; different revisions require separate comparisons.
Package mirrors and cookbook dependencies can still introduce network noise.

All 12 historical `action.yml` revisions in `actionshub/chef-install` use
Node 12, Node 16, Node 20 or composite execution. No Docker installer
was identified in that history. Docker-versus-composite installation performance
remains untested. Docker containers used by Dokken are a separate concern.

## Local checks

```sh
shellcheck .github/scripts/*.sh .github/scripts/tests/*.sh
actionlint -no-color .github/workflows/workstation-shell-trial.yml
bash .github/scripts/tests/test-run-kitchen.sh
python3 .github/scripts/tests/test-report-ci-trial.py
INSTALLER_SCRIPTS=/path/to/pr81/.github/actions/install-workstation/scripts \
  bash .github/scripts/tests/test-installer-failures.sh
```

The installer failure tests use fake commands and never download or install
Workstation. They verify HTTP download failure and missing executable errors.
