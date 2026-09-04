# Changelog

## 0.2.0 - 2026-09-04

- Adds WCS CSV point import with quoted-field parsing and invalid-row reporting.
- Adds curve-based chainage and absolute-offset labels.
- Adds clamped linear elevation interpolation between two control points.
- Changes `CTPROFILE` to calculate real curve stations instead of row numbers.
- Converts entity OCS points and interactive UCS points to WCS before calculations.
- Adds command-level Undo marks and error cleanup, including closing CSV handles.
- Adds versioned release packaging, SHA-256 checksums, CI artifacts, and tag asset publishing.
- Adds bilingual onboarding, a command reference, a CAD test matrix, a roadmap, and contribution templates.
- Retains an explicit limitation: interactive AutoCAD/BricsCAD testing is still pending.

## 0.1.1 - 2026-08-08

- Clarifies that CSV output uses the host CAD text encoding; UTF-8 conversion is not claimed until verified on Windows CAD.
- Records the VPS QA limitation: no AutoCAD, BricsCAD, or Wine runtime is installed here.

## 0.1.0 - 2026-08-08

- First independent community release.
- Adds coordinate labels, CSV export, elevation labels, and a basic profile table.
- Adds static repository checks and original sample fixtures.
