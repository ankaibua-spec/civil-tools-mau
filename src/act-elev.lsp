;;; Elevation label command.
;;; SPDX-License-Identifier: GPL-3.0-or-later

(defun ACT:elevation-label-at (point / set index entity data found)
  (setq set (ssget "X" '((0 . "TEXT") (8 . "ACT-ELEV"))) index 0 found nil)
  (if set
    (repeat (sslength set)
      (setq entity (ssname set index) data (entget entity))
      (if (equal (cdr (assoc 10 data)) point 0.000001)
        (setq found entity)
      )
      (setq index (1+ index))
    )
  )
  found
)

(defun ACT:write-elevation-label (point text layer / existing data)
  (setq existing (ACT:elevation-label-at point))
  (if existing
    (progn
      (setq data (subst (cons 1 text) (assoc 1 (entget existing)) (entget existing)))
      (entmod data)
      "Updated"
    )
    (progn
      (entmake (list (cons 0 "TEXT") (cons 8 layer) (cons 10 point) (cons 40 2.5) (cons 1 text) (cons 7 (getvar "TEXTSTYLE")) (cons 50 0.0)))
      "Added"
    )
  )
)

(defun C:CTELEV (/ entity point elevation layer text)
  (setq entity (car (entsel "\nSelect a POINT for elevation: ")))
  (cond
    ((not entity) (ACT:message "Nothing selected."))
    ((/= (cdr (assoc 0 (entget entity))) "POINT") (ACT:message "Select a POINT entity."))
    ((not (setq elevation (getreal "\nElevation: "))) (ACT:message "Elevation was cancelled."))
    (T
      (setq point (ACT:entity-point entity) layer (ACT:ensure-layer "ACT-ELEV" 1) text (strcat "EL=" (ACT:number elevation)))
      (ACT:message (strcat (ACT:write-elevation-label point text layer) " " text "."))
    )
  )
  (princ)
)

(princ)
