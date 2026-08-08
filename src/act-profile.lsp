;;; Basic chainage/elevation table command.
;;; SPDX-License-Identifier: GPL-3.0-or-later

(defun ACT:profile-row (entity / point)
  (setq point (ACT:entity-point entity))
  (if point (list entity point))
)

(defun C:CTPROFILE (/ set origin rows entity row point index layer y text)
  (setq set (ssget '((0 . "POINT"))))
  (cond
    ((not set) (ACT:message "No POINT entities selected."))
    ((not (setq origin (getpoint "\nSelect table insertion point: "))) (ACT:message "Table placement was cancelled."))
    (T
      (setq rows nil)
      (foreach entity (ACT:selection-list set)
        (if (setq row (ACT:profile-row entity)) (setq rows (cons row rows)))
      )
      (setq rows (ACT:sort-by-x rows) layer (ACT:ensure-layer "ACT-PROFILE" 5) index 1 y (cadr origin))
      (entmake (list (cons 0 "TEXT") (cons 8 layer) (cons 10 origin) (cons 40 2.5) (cons 1 "CHAINAGE,ELEVATION,X,Y") (cons 7 (getvar "TEXTSTYLE"))))
      (foreach row rows
        (setq point (cadr row) text (strcat (itoa index) "," (ACT:number (caddr point)) "," (ACT:number (car point)) "," (ACT:number (cadr point))))
        (entmake (list (cons 0 "TEXT") (cons 8 layer) (cons 10 (list (car origin) (- y (* index 3.5)) (caddr origin))) (cons 40 2.5) (cons 1 text) (cons 7 (getvar "TEXTSTYLE"))))
        (setq index (1+ index))
      )
      (ACT:message (strcat "Created a profile table with " (itoa (1- index)) " rows."))
    )
  )
  (princ)
)

(princ)
