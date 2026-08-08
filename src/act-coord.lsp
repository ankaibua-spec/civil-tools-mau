;;; Coordinate labelling command.
;;; SPDX-License-Identifier: GPL-3.0-or-later

(defun C:CTCOORD (/ set index entity point number layer label)
  (setq set (ssget '((0 . "POINT"))))
  (if (not set)
    (ACT:message "No POINT entities selected.")
    (progn
      (setq layer (ACT:ensure-layer "ACT-COORD" 3) index 0 number 1)
      (repeat (sslength set)
        (setq entity (ssname set index) point (ACT:entity-point entity))
        (if point
          (progn
            (setq label (strcat "P" (itoa number) " " (ACT:point-text point)))
            (entmake (list (cons 0 "TEXT") (cons 8 layer) (cons 10 point) (cons 40 2.5) (cons 1 label) (cons 7 (getvar "TEXTSTYLE")) (cons 50 0.0)))
            (setq number (1+ number))
          )
        )
        (setq index (1+ index))
      )
      (ACT:message (strcat "Created " (itoa (1- number)) " coordinate labels."))
    )
  )
  (princ)
)

(princ)
