;;; Shared helpers. All functions are original for this project.
;;; SPDX-License-Identifier: GPL-3.0-or-later

(defun ACT:message (text)
  (prompt (strcat "\nACT: " text))
)

(defun ACT:number (value)
  (if (numberp value) (rtos value 2 3) "0.000")
)

(defun ACT:point-text (point)
  (strcat "X=" (ACT:number (car point)) ", Y=" (ACT:number (cadr point)) ", Z=" (ACT:number (caddr point)))
)

(defun ACT:ensure-layer (name color / data)
  (if (not (tblsearch "LAYER" name))
    (entmake (list (cons 0 "LAYER") (cons 100 "AcDbSymbolTableRecord") (cons 100 "AcDbLayerTableRecord") (cons 2 name) (cons 70 0) (cons 62 color) (cons 6 "Continuous")))
  )
  name
)

(defun ACT:selection-list (set / index result)
  (setq index 0 result nil)
  (if set
    (repeat (sslength set)
      (setq result (cons (ssname set index) result))
      (setq index (1+ index))
    )
  )
  (reverse result)
)

(defun ACT:entity-point (entity / data kind)
  (setq data (entget entity) kind (cdr (assoc 0 data)))
  (cond
    ((= kind "POINT") (cdr (assoc 10 data)))
    ((= kind "TEXT") (cdr (assoc 10 data)))
    (T nil)
  )
)

(defun ACT:csv-quote (text / clean)
  (setq clean (vl-string-subst "\"\"" "\"" (if text text "")))
  (strcat "\"" clean "\"")
)

(defun ACT:sort-by-x (points)
  (vl-sort points '(lambda (left right) (< (car (cdr left)) (car (cdr right)))))
)

(defun ACT:safe-text (value)
  (if (= (type value) 'STR) value "")
)

(princ)
