# AutoLISP Civil Tools Community - Huong dan tieng Viet

Day la bo lenh AutoLISP ma nguon mo GPL-3.0-or-later cho cac thao tac trac dia va ha tang nho. Du an nay doc lap, khong sao chep ma nguon hoac du lieu tu bo cong cu thuong mai.

## Cai dat

1. Tai file ZIP cua ban phat hanh va doi chieu voi `CHECKSUMS.txt`.
2. Giai nen vao thu muc local co quyen ghi.
3. Trong AutoCAD hoac BricsCAD, go `APPLOAD` va nap `src/act-load.lsp`.
4. Kiem tra dong thong bao co phien ban `0.2.0`.

## Bay lenh

- `CTCOORD`: ghi nhan ID va toa do WCS X/Y/Z cho POINT.
- `CTEXPORT`: xuat POINT va TEXT ra CSV theo WCS.
- `CTIMPORT`: nhap POINT tu CSV co ba cot `x`, `y`, `z`.
- `CTELEV`: tao hoac cap nhat nhan cao do tai POINT.
- `CTCHAINAGE`: ghi ly trinh va khoang cach tuyet doi den duong tim.
- `CTINTERP`: noi suy cao do tu hai POINT khong che; ket qua duoc gioi han trong doan.
- `CTPROFILE`: tao bang ly trinh, cao do, toa do va khoang cach den duong tim.

## Luu y quan trong

Toa do CSV va phep tinh deu theo WCS. Ly trinh bat dau tu dau cua duong cong da chon. Offset hien tai la gia tri tuyet doi, chua phan trai/phai. File CSV dung bang ma ky tu cua CAD dang chay.

Ban v0.2.0 da qua kiem tra tinh tren Linux nhung chua duoc chay truc tiep trong AutoCAD hoac BricsCAD. Hay dung ban ve mau, kiem tra don vi va he toa do, sau do doi chieu ket qua truoc khi dung cho ho so san xuat.
