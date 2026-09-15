#!/usr/bin/env python3
"""Summarise downloaded trial artifacts and the GitHub jobs API response."""
import argparse
import datetime
import json
from pathlib import Path
import statistics


def report(artifacts, jobs):
    results = {}
    for path in Path(artifacts).rglob('trial-result.json'):
        result = json.loads(path.read_text())
        key = tuple(result[field] for field in ('variant', 'repeat', 'suite', 'os'))
        if key in results:
            raise ValueError(f'Duplicate result: {key}; use one run attempt per directory')
        results[key] = result
    rows = []
    for job in jobs:
        if not job['name'].startswith('trial / '):
            continue
        key = tuple(job['name'].split(' / ')[1:])
        result = dict(results.get(key, {}))
        installer = 'Install current Workstation' if key[0] == 'current-js' else 'Install proposed Workstation'
        for step in job.get('steps', []):
            if step['name'] == installer:
                result['install_status'] = step['conclusion']
        started, completed = job.get('started_at'), job.get('completed_at')
        total = None
        if started and completed:
            total = (datetime.datetime.fromisoformat(completed.replace('Z', '+00:00')) -
                     datetime.datetime.fromisoformat(started.replace('Z', '+00:00'))).total_seconds()
        rows.append(dict(result, variant=key[0], repeat=key[1], suite=key[2], os=key[3],
                         status=job.get('conclusion') or job.get('status', 'unknown'), total_seconds=total, url=job['html_url']))
    lines = ['# Nginx Workstation shell trial', '',
             'Times are seconds. Job totals include setup, image pulls and artifact upload, but exclude queue time.', '',
             '| Variant | Repeat | Instance | Result | Install | Kitchen | Job |',
             '| --- | --- | --- | --- | ---: | ---: | ---: |']
    def number(value):
        return 'unavailable' if value is None else f'{value:.3f}'
    for row in rows:
        lines.append(f"| {row['variant']} | {row['repeat']} | {row['suite']}-{row['os']} | "
                     f"[{row['status']}]({row['url']}) | {number(row.get('install_seconds'))} | "
                     f"{number(row.get('kitchen_seconds'))} | {number(row['total_seconds'])} |")
    lines += ['', '## Summary', '']
    medians = {}
    for variant in ('current-js', 'proposed-js', 'proposed-shell'):
        group = [row for row in rows if row['variant'] == variant]
        failures = sum(row['status'] != 'success' for row in group)
        lines.append(f'- {variant}: {len(group)} attempts, {failures} unsuccessful.')
        for metric in ('install_seconds', 'kitchen_seconds', 'total_seconds'):
            # Failed installs are retained above, but must not make a fast failure look faster.
            values = [row[metric] for row in group if row.get(metric) is not None and
                      (row.get('install_status') == 'success' if metric == 'install_seconds' else row['status'] == 'success')]
            if values:
                median = statistics.median(values)
                medians[variant, metric] = median
                lines.append(f'  - {metric}: median {median:.3f}; range {min(values):.3f}–{max(values):.3f}; n={len(values)}.')
    for before, after, metric in [('current-js', 'proposed-js', 'install_seconds'),
                                  ('proposed-js', 'proposed-shell', 'kitchen_seconds'),
                                  ('current-js', 'proposed-js', 'total_seconds'),
                                  ('proposed-js', 'proposed-shell', 'total_seconds')]:
        if (before, metric) in medians and (after, metric) in medians:
            old, new = medians[before, metric], medians[after, metric]
            delta = new - old
            percent = 100 * delta / old if old else 0
            regression = delta > 5 and percent > 10
            lines.append(f'- {before} → {after}, {metric}: {delta:+.3f}s ({percent:+.1f}%). '
                         f'Material regression: {"yes" if regression else "no"}.')
    full = [row for row in rows if row['variant'] == 'full-shell']
    lines.append(f'- Full matrix: {sum(row["status"] == "success" for row in full)}/{len(full)} passed (27 expected).')
    images = sorted({(row.get('image_os') or 'unknown', row.get('image_version') or 'unknown') for row in rows})
    lines += ['', 'Runner images: ' + ', '.join('/'.join(image) for image in images), '',
              'A small trial does not establish long-term reliability. Missing results and failed attempts are not passes.']
    return '\n'.join(lines) + '\n'


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('artifacts')
    parser.add_argument('jobs_json', help='Object with jobs or a list of paginated jobs responses')
    args = parser.parse_args()
    payload = json.loads(Path(args.jobs_json).read_text())
    jobs = [job for page in payload for job in page['jobs']] if isinstance(payload, list) else payload['jobs']
    print(report(args.artifacts, jobs), end='')
