#!/usr/bin/env python3
import importlib.util
import json
from pathlib import Path
import tempfile
import unittest

spec = importlib.util.spec_from_file_location('report', Path(__file__).parents[1] / 'report-ci-trial.py')
module = importlib.util.module_from_spec(spec)
spec.loader.exec_module(module)


class ReportTest(unittest.TestCase):
    def test_failed_install_does_not_improve_median_and_missing_artifact_is_visible(self):
        with tempfile.TemporaryDirectory() as directory:
            jobs = []
            for repeat, seconds, status in [('1', 30, 'success'), ('2', 1, 'failure'), ('3', None, 'failure')]:
                jobs.append(dict(name=f'trial / current-js / {repeat} / distro / ubuntu-2404',
                                 conclusion=status, started_at='2026-09-15T10:00:00Z',
                                 completed_at='2026-09-15T10:02:00Z', html_url='https://example.com/job'))
                if seconds is not None:
                    path = Path(directory) / repeat
                    path.mkdir()
                    (path / 'trial-result.json').write_text(json.dumps(dict(
                        variant='current-js', repeat=repeat, suite='distro', os='ubuntu-2404',
                        install_seconds=seconds, install_status=status)))
            result = module.report(directory, jobs)
            self.assertIn('3 attempts, 2 unsuccessful', result)
            self.assertIn('install_seconds: median 30.000', result)
            self.assertIn('unavailable', result)
            self.assertIn('120.000', result)


if __name__ == '__main__':
    unittest.main()
