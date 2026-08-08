# Release checklist

- [ ] Run `python3 tests/check_repo.py`.
- [ ] Open `examples/sample-survey.dxf` in AutoCAD or BricsCAD and smoke-test CTCOORD, CTEXPORT, CTELEV, and CTPROFILE.
- [ ] Confirm `IP_PROVENANCE.md` still reflects every included asset.
- [ ] Create a source archive from the tagged commit and publish its SHA-256 checksum.
- [ ] Write release notes with compatibility, tested CAD versions, and known limitations.
