# Contributing

Thank you for improving AutoLISP Civil Tools Community.

1. Search existing issues and open one before proposing a large feature.
2. Keep helpers in the `ACT:` namespace and public entry points in the documented `C:` command list.
3. Preserve the WCS calculation contract, user settings, command-level Undo behavior, and file cleanup.
4. Run `python3 tests/check_repo.py` and `bash scripts/package_release.sh`.
5. Test relevant commands manually in AutoCAD or BricsCAD when possible and report the exact product, version, operating system, drawing units, and result.
6. Confirm that every contribution is original or GPL-3.0-or-later compatible.

Small pull requests with a focused fixture or test are preferred. A CAD runtime report without a code change is also valuable.

Do not add credentials, telemetry, network calls, proprietary drawings, customer coordinates, or copied code whose license is unclear. Pull requests require maintainer review.
