# Reproducible CAD test matrix

Record product, exact version, Windows version, drawing units, and whether the current UCS is World or custom for every run.

| Case | Procedure | Expected result |
| --- | --- | --- |
| Load | `APPLOAD` `src/act-load.lsp` | Version 0.2.0 and seven command names appear; no network prompt. |
| Coordinates | Run `CTCOORD` on sample POINT entities | Labels show WCS coordinates and one Undo removes all new labels. |
| Export/import | Export sample points, Undo, then import the CSV | Header is stable; valid coordinates round-trip within 0.001 drawing unit. |
| Invalid CSV | Import `examples/import-points.csv` | Three points are created and two invalid rows are reported as skipped. |
| Elevation | Run `CTELEV` twice on one POINT | The second run updates the existing label; one Undo reverses one run. |
| Chainage | Choose a LINE or polyline and nearby POINT entities | Stations increase from curve start; offsets are non-negative. |
| Interpolation | Use controls Z=10 and Z=20 with midpoint target | Midpoint label is EL=15.000; outside targets clamp to 10 or 20. |
| Profile | Use the same alignment and points | Rows are ordered by real chainage and include absolute offsets. |
| Custom UCS | Translate and rotate UCS, then repeat coordinate/profile cases | Calculation values remain WCS; table placement follows picked UCS positions. |
| Error cleanup | Cancel each prompt and provide one malformed CSV | No open-file lock, incomplete Undo group, or changed CAD setting remains. |

Attach only synthetic drawings or a minimal reproduction. Never attach customer coordinates or proprietary source.
