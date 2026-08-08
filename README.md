# AutoLISP Civil Tools Community

GPL-3.0 tools for small civil-survey tasks in AutoCAD-compatible CAD software.

**Status:** v0.1.0 is a new community project. It is independent from any commercial toolkit.

## What it does

- `CTCOORD` labels selected POINT entities with an ID and X/Y/Z coordinate.
- `CTEXPORT` exports selected POINT and TEXT entities to a UTF-8 CSV file.
- `CTELEV` creates or updates an elevation label at a selected point.
- `CTPROFILE` creates a basic chainage/elevation table from selected POINT entities.

## Install

1. Download a release ZIP and extract it to a writable local folder.
2. In AutoCAD or BricsCAD, run `APPLOAD` and load `src/act-load.lsp`.
3. Run one of the commands above. The loader does not install an updater, make network calls, or collect telemetry.

`examples/sample-survey.dxf` is a minimal original sample drawing. `examples/expected-points.csv` documents the expected export shape.

## Compatibility

The project targets AutoCAD and BricsCAD with Visual LISP support. Test against your installed CAD version before using output in a production survey workflow.

## Development

Run `python3 tests/check_repo.py` before opening a pull request. The check verifies balanced parentheses, the loader manifest, duplicate public commands, and unsafe patterns.

## Contributing and security

Please read [CONTRIBUTING.md](CONTRIBUTING.md). Report vulnerabilities privately using the process in [SECURITY.md](SECURITY.md); do not post them as public issues.

## License

Copyright (C) 2026 Truong Hoa and contributors. Licensed under [GPL-3.0-or-later](LICENSE).
