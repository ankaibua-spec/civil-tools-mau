;;; Lenh    : HVSO
;;; Muc dich: danh so thu tu tang dan len ban ve (TEXT can giua, layer HV_SO).
;;; Cach dung: go HVSO, nhap so bat dau <1> va chieu cao chu <2.5>, click lan
;;;            luot cac diem; Enter hoac Esc de ket thuc.
;;; SPDX-License-Identifier: GPL-3.0-or-later

(vl-load-com)

;; Middle-center TEXT at a UCS point, lying in the current UCS plane and
;; reading along the UCS X axis. Returns nil if the entity was not created.
(defun HV:so-text (point text layer height / normal place rotation)
  (setq normal (trans '(0.0 0.0 1.0) 1 0 T)
        place (trans point 1 normal)
        rotation (angle '(0.0 0.0 0.0) (trans (getvar "UCSXDIR") 0 normal T)))
  (entmakex
    (list
      (cons 0 "TEXT")
      (cons 8 layer)
      (cons 10 place)
      (cons 40 height)
      (cons 1 text)
      (cons 50 rotation)
      (cons 7 (getvar "TEXTSTYLE"))
      (cons 72 1)
      (cons 11 place)
      (cons 73 2)
      (cons 210 normal)
    )
  )
)

(defun C:HVSO (/ *error* document number height layer point)
  (defun *error* (message) (ACT:report-error message document))
  (setq document (ACT:undo-start))
  (initget 4)
  (setq number (getint "\nSo bat dau <1>: "))
  (if (not number) (setq number 1))
  (initget 6)
  (setq height (getreal "\nChieu cao chu <2.5>: "))
  (if (not height) (setq height 2.5))
  (setq layer (ACT:ensure-layer "HV_SO" 2))
  (while (setq point (getpoint (strcat "\nChon diem cho so " (itoa number) " <ket thuc>: ")))
    (if (HV:so-text point (itoa number) layer height)
      (setq number (1+ number))
      (prompt "\nHVSO: khong tao duoc TEXT.")
    )
  )
  (ACT:undo-end document)
  (setq document nil)
  (princ)
)

(princ)
