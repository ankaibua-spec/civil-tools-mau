# QA report — 2026-08-08

## Environment

| Check | Result |
| --- | --- |
| Repository commit | `94df7d3` before this documentation patch |
| Static QA | PASS: `python3 tests/check_repo.py` |
| Parentheses and public-command uniqueness | PASS |
| GitHub Actions QA | PASS (run 31248350513 on v0.1.0) |
| AutoCAD version | NOT TESTED: no AutoCAD executable on the VPS |
| BricsCAD version | NOT TESTED: no BricsCAD executable on the VPS |
| Wine/Windows compatibility layer | NOT TESTED: Wine is not installed |

## Four-command status

`CTCOORD`, `CTEXPORT`, `CTELEV`, and `CTPROFILE` passed source-level checks only. No claim is made about interactive CAD behavior until a maintainer runs the commands in a real AutoCAD or BricsCAD session.

## Required Windows smoke test

Open `examples/sample-survey.dxf`, load `src/act-load.lsp`, and run each command once. Record the exact CAD product, version, operating system, result, and any error text in a follow-up issue or release note. Do not upload customer drawings.

