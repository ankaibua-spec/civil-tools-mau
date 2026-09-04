# QA report - 2026-09-04

## Automated environment

| Check | Result |
| --- | --- |
| Target | v0.2.0 source snapshot |
| Static QA | PASS: `python3 tests/check_repo.py` |
| Parentheses, manifest, version, and command uniqueness | PASS |
| Network/credential runtime patterns | PASS: none detected in AutoLISP source |
| Package script and ZIP integrity | Pending tagged-commit verification |
| GitHub Actions QA | Pending v0.2.0 push/tag |
| AutoCAD runtime | NOT TESTED: AutoCAD is not installed on the VPS |
| BricsCAD runtime | NOT TESTED: BricsCAD is not installed on the VPS |
| Wine compatibility layer | NOT TESTED: Wine is not installed on the VPS |

## Seven-command status

`CTCOORD`, `CTEXPORT`, `CTIMPORT`, `CTELEV`, `CTCHAINAGE`, `CTINTERP`, and `CTPROFILE` pass source-level checks only. No claim is made about interactive CAD compatibility until a maintainer or contributor completes the Windows matrix.

## Required independent CAD test

Follow [docs/CAD_TEST_MATRIX.md](docs/CAD_TEST_MATRIX.md). Do not upload customer drawings, credentials, or private toolkit code. Test reports should include exact reproduction steps and full command-line error text.
