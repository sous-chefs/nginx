# Nginx Workstation shell trial results

## Decision

Recommend shell composite actions as a future direction for debugging and
maintenance. This trial does **not** demonstrate a dependable installation
speed improvement or establish better long-term reliability.

[The evidence run](https://github.com/sous-chefs/nginx/actions/runs/34944053247)
passed all 15 benchmark jobs, all 27 full-matrix jobs, and the script contract
and simulated failure tests. The PR's normal CI also passed on the tested
implementation. No merges or wider cookbook migration were performed.

| Variant | Install median | Kitchen median | Job median |
| --- | ---: | ---: | ---: |
| Current installer + JavaScript | 26.445s | 31.462s | 78s |
| PR #81 + JavaScript | 24.816s | 33.025s | 78s |
| PR #81 + shell | 42.382s | 34.351s | 102s |

The controlled installer comparison improved by 1.629 seconds (6.2%). The
controlled wrapper comparison increased by 1.326 seconds (4.0%). Neither
is a material difference under the trial's five-second and 10% threshold.

The shell variant's **total-job median increased by 24 seconds (30.8%)**,
which triggered investigation. Its identical installer also had a much
higher median. The logs show package-download variation before Kitchen ran:

- [Shell repetition 1](https://github.com/sous-chefs/nginx/actions/runs/34944053247/job/104299200775):
  package download started at 07:54:04.741 UTC; installation started at
  07:54:07.215 UTC, a 2.474-second interval.
- [Shell repetition 4](https://github.com/sous-chefs/nginx/actions/runs/34944053247/job/104299200911):
  package download started at 07:56:21.898 UTC; installation started at
  07:57:17.332 UTC, a 55.434-second interval.

These intervals include the package download and pre-install verification.
This is evidence of substantial download-stage variation, not evidence that
changing the Kitchen wrapper slows installation. Retain the total-job
regression in the results; do not advertise an end-to-end speed improvement.

The shell wrapper prints the selected instance, executable and version, and
its fake-command tests prove argument handling and failure propagation. The
installer logs inputs and resolved outputs. Real Nginx converge and verifier
logs were retained for all 42 trial jobs.

All jobs used runner image `ubuntu24/20260907.300.1`, Cinc Workstation 26.2.4,
and the same pinned Nginx subject. The tested harness commit is
`3f300b8`; later edits correct result metadata selection, improve the report
and make future runs manual. The report uses GitHub's installer-step
conclusion, because the original artifact expression selected the skipped
baseline step for proposed variants. Timing values are unchanged.

GitHub downloads all referenced actions before conditional steps run, so
this trial does not measure the setup saving from removing the JavaScript
action entirely. No historical Docker installer existed in the inspected
`actionshub/chef-install` action history; Docker installation remains untested.

See [trial instructions](workstation-shell-trial.md) for pins, reproduction,
measurement boundaries and the local test commands.

## Individual measurements

Times are seconds. Job totals include setup, image pulls and artifact upload, but exclude queue time.

| Variant | Repeat | Instance | Result | Install | Kitchen | Job |
| --- | --- | --- | --- | ---: | ---: | ---: |
| current-js | 4 | distro-ubuntu-2404 | [success](https://github.com/sous-chefs/nginx/actions/runs/34944053247/job/104299200682) | 26.445 | 31.462 | 78.000 |
| current-js | 3 | distro-ubuntu-2404 | [success](https://github.com/sous-chefs/nginx/actions/runs/34944053247/job/104299200699) | 78.499 | 36.616 | 141.000 |
| current-js | 5 | distro-ubuntu-2404 | [success](https://github.com/sous-chefs/nginx/actions/runs/34944053247/job/104299200701) | 14.224 | 32.525 | 67.000 |
| current-js | 2 | distro-ubuntu-2404 | [success](https://github.com/sous-chefs/nginx/actions/runs/34944053247/job/104299200702) | 14.159 | 30.969 | 68.000 |
| proposed-shell | 5 | distro-ubuntu-2404 | [success](https://github.com/sous-chefs/nginx/actions/runs/34944053247/job/104299200715) | 42.382 | 34.351 | 102.000 |
| full-shell | 1 | distro-almalinux-8 | [success](https://github.com/sous-chefs/nginx/actions/runs/34944053247/job/104299200717) | 15.013 | 54.196 | 94.000 |
| proposed-shell | 3 | distro-ubuntu-2404 | [success](https://github.com/sous-chefs/nginx/actions/runs/34944053247/job/104299200720) | 83.402 | 36.801 | 149.000 |
| proposed-shell | 2 | distro-ubuntu-2404 | [success](https://github.com/sous-chefs/nginx/actions/runs/34944053247/job/104299200726) | 19.027 | 34.127 | 74.000 |
| current-js | 1 | distro-ubuntu-2404 | [success](https://github.com/sous-chefs/nginx/actions/runs/34944053247/job/104299200754) | 76.679 | 31.189 | 133.000 |
| proposed-js | 4 | distro-ubuntu-2404 | [success](https://github.com/sous-chefs/nginx/actions/runs/34944053247/job/104299200756) | 16.255 | 33.390 | 75.000 |
| proposed-js | 2 | distro-ubuntu-2404 | [success](https://github.com/sous-chefs/nginx/actions/runs/34944053247/job/104299200759) | 27.609 | 30.098 | 78.000 |
| proposed-shell | 1 | distro-ubuntu-2404 | [success](https://github.com/sous-chefs/nginx/actions/runs/34944053247/job/104299200775) | 16.049 | 35.139 | 75.000 |
| proposed-js | 5 | distro-ubuntu-2404 | [success](https://github.com/sous-chefs/nginx/actions/runs/34944053247/job/104299200786) | 13.943 | 33.025 | 70.000 |
| proposed-js | 1 | distro-ubuntu-2404 | [success](https://github.com/sous-chefs/nginx/actions/runs/34944053247/job/104299200789) | 24.816 | 32.520 | 83.000 |
| proposed-js | 3 | distro-ubuntu-2404 | [success](https://github.com/sous-chefs/nginx/actions/runs/34944053247/job/104299200791) | 31.435 | 33.757 | 86.000 |
| proposed-shell | 4 | distro-ubuntu-2404 | [success](https://github.com/sous-chefs/nginx/actions/runs/34944053247/job/104299200911) | 68.553 | 34.316 | 128.000 |
| full-shell | 1 | distro-almalinux-9 | [success](https://github.com/sous-chefs/nginx/actions/runs/34944053247/job/104299201825) | 35.627 | 31.921 | 100.000 |
| full-shell | 1 | distro-centos-stream-10 | [success](https://github.com/sous-chefs/nginx/actions/runs/34944053247/job/104299201976) | 20.662 | 31.725 | 85.000 |
| full-shell | 1 | distro-centos-stream-9 | [success](https://github.com/sous-chefs/nginx/actions/runs/34944053247/job/104299202015) | 17.257 | 35.974 | 78.000 |
| full-shell | 1 | distro-amazonlinux-2023 | [success](https://github.com/sous-chefs/nginx/actions/runs/34944053247/job/104299202059) | 80.391 | 158.922 | 262.000 |
| full-shell | 1 | distro-debian-12 | [success](https://github.com/sous-chefs/nginx/actions/runs/34944053247/job/104299202123) | 18.102 | 26.670 | 70.000 |
| full-shell | 1 | distro-rockylinux-8 | [success](https://github.com/sous-chefs/nginx/actions/runs/34944053247/job/104299202162) | 20.062 | 52.701 | 102.000 |
| full-shell | 1 | distro-rockylinux-9 | [success](https://github.com/sous-chefs/nginx/actions/runs/34944053247/job/104299202245) | 48.824 | 93.317 | 165.000 |
| full-shell | 1 | distro-ubuntu-2404 | [success](https://github.com/sous-chefs/nginx/actions/runs/34944053247/job/104299202274) | 28.272 | 34.618 | 91.000 |
| full-shell | 1 | distro-ubuntu-2204 | [success](https://github.com/sous-chefs/nginx/actions/runs/34944053247/job/104299202276) | 35.658 | 35.653 | 93.000 |
| full-shell | 1 | repo-almalinux-8 | [success](https://github.com/sous-chefs/nginx/actions/runs/34944053247/job/104299202399) | 19.491 | 52.833 | 101.000 |
| full-shell | 1 | repo-almalinux-9 | [success](https://github.com/sous-chefs/nginx/actions/runs/34944053247/job/104299202993) | 16.990 | 40.231 | 84.000 |
| full-shell | 1 | repo-amazonlinux-2023 | [success](https://github.com/sous-chefs/nginx/actions/runs/34944053247/job/104299203061) | 17.553 | 160.862 | 200.000 |
| full-shell | 1 | repo-centos-stream-9 | [success](https://github.com/sous-chefs/nginx/actions/runs/34944053247/job/104299203172) | 14.894 | 66.387 | 102.000 |
| full-shell | 1 | repo-debian-12 | [success](https://github.com/sous-chefs/nginx/actions/runs/34944053247/job/104299203355) | 33.400 | 27.405 | 90.000 |
| full-shell | 1 | repo-rockylinux-9 | [success](https://github.com/sous-chefs/nginx/actions/runs/34944053247/job/104299203435) | 113.282 | 35.982 | 175.000 |
| full-shell | 1 | repo-rockylinux-8 | [success](https://github.com/sous-chefs/nginx/actions/runs/34944053247/job/104299203441) | 103.328 | 47.807 | 177.000 |
| full-shell | 1 | repo-ubuntu-2204 | [success](https://github.com/sous-chefs/nginx/actions/runs/34944053247/job/104299203537) | 32.204 | 38.608 | 96.000 |
| full-shell | 1 | repo-ubuntu-2404 | [success](https://github.com/sous-chefs/nginx/actions/runs/34944053247/job/104299203607) | 59.519 | 44.736 | 134.000 |
| full-shell | 1 | epel-almalinux-8 | [success](https://github.com/sous-chefs/nginx/actions/runs/34944053247/job/104299203680) | 17.489 | 65.681 | 106.000 |
| full-shell | 1 | epel-almalinux-9 | [success](https://github.com/sous-chefs/nginx/actions/runs/34944053247/job/104299203708) | 18.381 | 45.936 | 89.000 |
| full-shell | 1 | epel-centos-stream-10 | [success](https://github.com/sous-chefs/nginx/actions/runs/34944053247/job/104299204266) | 17.812 | 36.075 | 86.000 |
| full-shell | 1 | epel-centos-stream-9 | [success](https://github.com/sous-chefs/nginx/actions/runs/34944053247/job/104299204289) | 15.798 | 55.496 | 95.000 |
| full-shell | 1 | epel-rockylinux-8 | [success](https://github.com/sous-chefs/nginx/actions/runs/34944053247/job/104299204392) | 15.461 | 67.043 | 108.000 |
| full-shell | 1 | epel-rockylinux-9 | [success](https://github.com/sous-chefs/nginx/actions/runs/34944053247/job/104299204500) | 26.948 | 44.874 | 100.000 |
| full-shell | 1 | distro-nginx-full-ubuntu-2204 | [success](https://github.com/sous-chefs/nginx/actions/runs/34944053247/job/104299204506) | 121.068 | 36.697 | 180.000 |
| full-shell | 1 | distro-nginx-full-ubuntu-2404 | [success](https://github.com/sous-chefs/nginx/actions/runs/34944053247/job/104299204627) | 17.435 | 29.984 | 72.000 |

## Timing summary

- current-js: 5 attempts, 0 unsuccessful.
  - install_seconds: median 26.445; range 14.159–78.499; n=5.
  - kitchen_seconds: median 31.462; range 30.969–36.616; n=5.
  - total_seconds: median 78.000; range 67.000–141.000; n=5.
- proposed-js: 5 attempts, 0 unsuccessful.
  - install_seconds: median 24.816; range 13.943–31.435; n=5.
  - kitchen_seconds: median 33.025; range 30.098–33.757; n=5.
  - total_seconds: median 78.000; range 70.000–86.000; n=5.
- proposed-shell: 5 attempts, 0 unsuccessful.
  - install_seconds: median 42.382; range 16.049–83.402; n=5.
  - kitchen_seconds: median 34.351; range 34.127–36.801; n=5.
  - total_seconds: median 102.000; range 74.000–149.000; n=5.
- current-js → proposed-js, install_seconds: -1.629s (-6.2%). Material regression: no.
- proposed-js → proposed-shell, kitchen_seconds: +1.326s (+4.0%). Material regression: no.
- current-js → proposed-js, total_seconds: +0.000s (+0.0%). Material regression: no.
- proposed-js → proposed-shell, total_seconds: +24.000s (+30.8%). Material regression: yes.
- Full matrix: 27/27 passed (27 expected).

Runner images: ubuntu24/20260907.300.1

A small trial does not establish long-term reliability. Missing results and failed attempts are not passes.
