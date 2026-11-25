# AutoLISP Civil Tools Community

Small, auditable GPL-3.0-or-later tools for civil-survey work in AutoCAD-compatible CAD software.

**Status:** v0.3.0 source is ready for community CAD testing. This is an independent public project and contains no code or data from private commercial toolkits.

[Huong dan tieng Viet khong dau](docs/README.vi.md) | [Command reference](docs/COMMANDS.md) | [Roadmap](ROADMAP.md)

## HVLisp

HVLisp là bản sửa đổi (từ 2026-11-25) của AutoLISP Civil Tools Community, giữ nguyên giấy phép GPL-3.0-or-later. Bộ này giữ 7 lệnh CT và thêm lệnh riêng tiền tố `HV` trong thư mục `lenh/`.

### Cách cài

1. Tải <https://github.com/ankaibua-spec/civil-tools-mau/archive/refs/heads/main.zip>.
2. Giải nén, chép **nội dung bên trong** thư mục `civil-tools-mau-main` vào `C:\HVLisp`. Phải có file `C:\HVLisp\src\act-load.lsp`.
3. Trong AutoCAD, vào `OPTIONS` > Files > Trusted Locations, thêm `C:\HVLisp\...` để không bị hỏi cảnh báo bảo mật.
4. Gõ `APPLOAD`, nạp `C:\HVLisp\src\act-load.lsp`. Muốn tự nạp mỗi lần mở AutoCAD thì thêm file này vào Startup Suite.
5. Dòng lệnh báo `HVLisp v0.3.0 - go HVHELP de xem lenh` là xong.

### Cách cập nhật

Gõ `HVUPDATE` trong AutoCAD. Lệnh này chạy `update.ps1`, tải nhánh `main` của repo, ghi đè vào thư mục gốc rồi nạp lại. AutoCAD đứng chờ trong lúc tải. Cần Windows có PowerShell 5 trở lên, có mạng, và repo ở chế độ public.

Lưu ý:

- File trùng tên trong thư mục gốc bị **ghi đè**; đừng sửa trực tiếp trong `C:\HVLisp`.
- File đã xóa hoặc đổi tên trên GitHub vẫn còn trên máy; cần xóa tay.
- Nếu không có `C:\HVLisp`, thư mục gốc là thư mục tìm được qua đường dẫn hỗ trợ (support path) của AutoCAD, và `HVUPDATE` sẽ ghi đè vào đó.
- `HVUPDATE` tải và chạy mã từ `main` mà không kiểm tra chữ ký. Ai có quyền push vào repo thì quyết định được mã chạy trên máy bạn.

### Danh sách lệnh

Gõ `HVHELP` để xem trong AutoCAD (nội dung từ `lenh/danh-sach.txt`).

| Lệnh | Mô tả |
| --- | --- |
| `CTCOORD` | Ghi nhãn ID và tọa độ WCS X/Y/Z cho POINT. |
| `CTEXPORT` | Xuất POINT và TEXT ra CSV theo WCS. |
| `CTIMPORT` | Nhập POINT từ CSV có cột `x`, `y`, `z`. |
| `CTELEV` | Tạo hoặc cập nhật nhãn cao độ tại POINT. |
| `CTCHAINAGE` | Ghi lý trình và offset của POINT theo đường cong. |
| `CTINTERP` | Nội suy cao độ từ hai POINT khống chế. |
| `CTPROFILE` | Tạo bảng lý trình, cao độ, offset cho POINT. |
| `HVUPDATE` | Cập nhật HVLisp từ GitHub. |
| `HVHELP` | Xem danh sách lệnh. |

## Commands

| Command | Purpose |
| --- | --- |
| `CTCOORD` | Label selected POINT entities with ID and WCS X/Y/Z coordinates. |
| `CTEXPORT` | Export selected POINT and TEXT entities to a WCS CSV file. |
| `CTIMPORT` | Import POINT entities from a CSV file with `x`, `y`, and `z` columns. |
| `CTELEV` | Create or update an elevation label at a selected POINT. |
| `CTCHAINAGE` | Label station and absolute offset for POINT entities along a selected curve. |
| `CTINTERP` | Interpolate clamped elevation labels between two control POINT entities. |
| `CTPROFILE` | Create a station/elevation/offset table for POINT entities along a selected curve. |

## Install

See [HVLisp](#hvlisp) above. The loader makes no network calls and collects no telemetry; only `HVUPDATE`, when you run it, connects to GitHub.

## Coordinate and data policy

All exported/imported coordinates and calculation inputs are WCS values. Entity DXF points are converted from OCS to WCS, and interactive table placement is converted from the current UCS to WCS. CSV files use the host CAD text encoding; UTF-8 output is not claimed until verified in supported Windows CAD versions.

`CTCHAINAGE` uses the selected curve start as station zero. Offsets are unsigned distances. `CTINTERP` projects targets in the WCS XY plane and clamps values to the elevation range between the two controls.

## Compatibility and test status

The target is AutoCAD and BricsCAD on Windows with Visual LISP curve/ActiveX support. Static QA and package validation run on every push. Interactive behavior has **not yet been verified in a real CAD runtime** because this Linux VPS has no AutoCAD, BricsCAD, or Wine installation. See [TEST_REPORT.md](TEST_REPORT.md) and the reproducible Windows checklist in [docs/CAD_TEST_MATRIX.md](docs/CAD_TEST_MATRIX.md).

Never rely on generated labels or CSV files as the sole source for production survey decisions. Review units, coordinate system, alignment direction, and results in the drawing.

## Development

```bash
python3 tests/check_repo.py
bash scripts/package_release.sh
unzip -t dist/autolisp-civil-tools-v0.3.0.zip
```

Please read [CONTRIBUTING.md](CONTRIBUTING.md). Report vulnerabilities privately using [SECURITY.md](SECURITY.md), not a public issue.

## License

Copyright (C) 2026 Truong Hoa and contributors. Licensed under [GPL-3.0-or-later](LICENSE).
