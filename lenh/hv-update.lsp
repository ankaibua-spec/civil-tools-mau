;;; Lenh    : HVUPDATE, HVHELP
;;; Muc dich: HVUPDATE tai ban moi nhat tu GitHub ve thu muc goc va nap lai.
;;;           HVHELP in danh sach lenh trong lenh\danh-sach.txt.
;;; Cach dung: go HVUPDATE hoac HVHELP tren dong lenh.
;;; SPDX-License-Identifier: GPL-3.0-or-later

(vl-load-com)

(setq HV:repo "ankaibua-spec/civil-tools-mau")

;; Root folder without a trailing backslash, which would escape the closing
;; quote on the powershell command line.
(defun HV:root (/ root)
  (if (setq root (ACT:root-dir))
    (vl-string-right-trim "\\/" root)
  )
)

;; Run a command in a hidden window, wait for it, and return its exit code.
;; Returns nil when the command could not be started.
(defun HV:run-wait (command / shell result)
  (setq shell (vl-catch-all-apply 'vlax-create-object (list "WScript.Shell")))
  (if (and shell (not (vl-catch-all-error-p shell)))
    (progn
      (setq result (vl-catch-all-apply 'vlax-invoke-method (list shell 'Run command 0 :vlax-true)))
      (vlax-release-object shell)
      (if (= (type result) 'VARIANT) (setq result (vlax-variant-value result)))
      (if (numberp result) result)
    )
  )
)

;; Error log written by update.ps1.
(defun HV:log-path (/ temp)
  (if (setq temp (getenv "TEMP"))
    (strcat temp "\\hvlisp-update.log")
  )
)

;; First line of that log, or nil.
(defun HV:read-log (/ path handle line)
  (if (setq path (HV:log-path))
    (if (findfile path) (setq handle (open path "r")))
  )
  (if handle
    (progn
      (setq line (read-line handle))
      (close handle)
    )
  )
  line
)

(defun C:HVUPDATE (/ *error* root script old new log detail code result)
  (defun *error* (message)
    (if (not (ACT:cancelled-error-p message))
      (prompt (strcat "\nHVUPDATE loi: " message))
    )
    (princ)
  )
  (setq root (HV:root))
  (if root (setq script (findfile (strcat root "\\update.ps1"))))
  (cond
    ((not root) (prompt "\nHVUPDATE that bai: khong tim thay thu muc goc."))
    ((not script) (prompt (strcat "\nHVUPDATE that bai: khong co file " root "\\update.ps1")))
    (T
      (setq old (if ACT:version ACT:version "?"))
      (if (setq log (HV:log-path))
        (if (findfile log) (vl-file-delete log))
      )
      (prompt "\nDang tai ban moi tu GitHub, vui long cho...")
      (setq code
        (HV:run-wait
          (strcat
            "powershell -NoProfile -ExecutionPolicy Bypass -File \"" root "\\update.ps1\""
            " -Repo \"" HV:repo "\""
            " -Dest \"" root "\""
          )
        )
      )
      (if (equal code 0)
        (progn
          (setq result (vl-catch-all-apply 'load (list (strcat root "\\src\\act-load.lsp"))))
          (if (vl-catch-all-error-p result)
            (prompt (strcat "\nDa tai xong nhung nap lai bi loi: " (vl-catch-all-error-message result)))
            (progn
              (setq new (if ACT:version ACT:version "?"))
              (if (= old new)
                (prompt "\nDang la ban moi nhat")
                (prompt (strcat "\nCap nhat: v" old " -> v" new))
              )
            )
          )
        )
        (progn
          (prompt
            (strcat
              "\nHVUPDATE that bai"
              (if code (strcat " (ma loi " (itoa code) ").") ": khong chay duoc powershell.")
            )
          )
          (if (setq detail (HV:read-log))
            (prompt (strcat "\nChi tiet: " detail))
          )
          (prompt (strcat "\nHay kiem tra ket noi mang va repo " HV:repo " co dang public khong."))
        )
      )
    )
  )
  (princ)
)

(defun C:HVHELP (/ root path handle line)
  (if (setq root (HV:root))
    (setq path (findfile (strcat root "\\lenh\\danh-sach.txt")))
  )
  (if path (setq handle (open path "r")))
  (if handle
    (progn
      (while (setq line (read-line handle))
        (prompt (strcat "\n" line))
      )
      (close handle)
    )
    (prompt "\nHVHELP: khong doc duoc file lenh\\danh-sach.txt")
  )
  (princ)
)

(princ)
