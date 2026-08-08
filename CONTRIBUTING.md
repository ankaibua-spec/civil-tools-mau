# Contributing

Thank you for improving AutoLISP Civil Tools Community.

1. Open an issue before proposing a large feature.
2. Keep each public command in the `ACT:` namespace except the four documented `C:` commands.
3. Add nil checks for user input and preserve the user's layer, text style, and undo state where applicable.
4. Run `python3 tests/check_repo.py` and test manually in AutoCAD or BricsCAD.
5. Confirm that your contribution is original or compatible with GPL-3.0-or-later.

Pull requests require maintainer review. Do not add credentials, telemetry, network calls, proprietary drawings, or copied code whose license is unclear.
