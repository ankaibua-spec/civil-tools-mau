# HVLisp

Bản fork của autolisp-civil-tools (bộ Lisp nền, GPL-3.0-or-later). Giữ nguyên `LICENSE` và dòng bản quyền gốc.

## Thông tin

- Tên bộ Lisp: HVLisp
- Tiền tố lệnh: HV
- Repo GitHub: ankaibua-spec/civil-tools-mau
- Thư mục cài trên máy (AutoCAD nạp từ đây): `C:\HVLisp`

## Cấu trúc

- `src/`: 7 lệnh CT và hàm dùng chung `ACT:*` (`src/act-core.lsp`). `src/act-load.lsp` là loader.
- `lenh/`: lệnh riêng của HVLisp, loader tự nạp mọi file `.lsp`. `lenh/danh-sach.txt` là nội dung của HVHELP.
- `update.ps1`: HVUPDATE gọi file này. Chỉ dùng ký tự ASCII.

## Quy tắc viết Lisp

1. Lệnh mới bắt đầu bằng tiền tố HV, mỗi lệnh một file trong `lenh\`, đầu file chú thích: tên lệnh, mục đích, cách dùng.
2. Không sửa các module trong `src/` trừ khi mình yêu cầu rõ.
3. Chữ hiện trên dòng lệnh dùng tiếng Việt KHÔNG DẤU.
4. Khai báo đủ biến cục bộ; kiểm tra nil trước `strcat`, `rtos`, `car`; `(vl-load-com)` trước `vlax-*`; `vlax-curve` bọc `vl-catch-all-apply`; lệnh có sửa bản vẽ dùng `ACT:undo-start` / `ACT:undo-end` và `*error*` trả lại biến hệ thống.
5. Dùng lại hàm `ACT:*` có sẵn trong `src/act-core.lsp`; ưu tiên `entmake`; vòng lặp dùng `cons` + `reverse`.
6. Trước khi commit chạy `python3 tests/check_repo.py` phải PASS.
7. Mỗi lần thêm/sửa lệnh: tăng `VERSION` (sửa lỗi +0.0.1, thêm lệnh +0.1.0), cập nhật `lenh\danh-sach.txt`, README, CHANGELOG, commit mô tả tiếng Việt, push lên main.
8. Không đưa mật khẩu, token, bản vẽ hay số liệu dự án vào repo.

## Ghi chú

- `lenh/hv-update.lsp` chứa cả HVUPDATE và HVHELP (ngoại lệ của quy tắc 1). Đây là file duy nhất được dùng lệnh mạng (http, WScript.Shell, powershell).
- Trước khi push, chạy `git remote -v`: đích phải là `ankaibua-spec/civil-tools-mau`, không phải `autolisp-civil-tools`.
- Máy dev không có AutoCAD: kiểm tra tĩnh PASS không có nghĩa là lệnh đã chạy được trong CAD. Phải nói rõ phần chưa thử.
