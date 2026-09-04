# Release checklist

- [ ] Confirm `VERSION`, loader version, changelog, tag, and release title match.
- [ ] Run `python3 tests/check_repo.py`.
- [ ] Run `bash scripts/package_release.sh` and test the ZIP with `unzip -t`.
- [ ] Confirm the ZIP contains only the documented public source, examples, and user documentation.
- [ ] Confirm `IP_PROVENANCE.md` reflects every included asset.
- [ ] Run all seven commands with `examples/sample-survey.dxf` and `examples/import-points.csv` in AutoCAD or BricsCAD.
- [ ] Test once in World UCS and once in a translated/rotated UCS.
- [ ] Verify a single Undo reverses each command's drawing changes.
- [ ] Record exact CAD versions and known limitations in `TEST_REPORT.md`.
- [ ] Publish the tagged source ZIP and `CHECKSUMS.txt`; download and verify both assets.
