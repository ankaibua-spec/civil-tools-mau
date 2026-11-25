;;; HVLisp loader, modified from the AutoLISP Civil Tools Community loader.
;;; Copyright (C) 2026 Truong Hoa and contributors.
;;; Modified for HVLisp on 2026-11-25: fixed install folder, version read from
;;; the VERSION file, and automatic loading of the lenh folder.
;;; SPDX-License-Identifier: GPL-3.0-or-later

(vl-load-com)

(setq ACT:install-dir "C:\\HVLisp")

;; Project root: the install folder when it holds a copy, otherwise the parent
;; of the folder where findfile locates this loader. Returns nil if not found.
(defun ACT:root-dir (/ path)
  (cond
    ((findfile (strcat ACT:install-dir "\\src\\act-load.lsp")) ACT:install-dir)
    ((setq path (findfile "act-load.lsp"))
      (vl-filename-directory (vl-filename-directory path))
    )
  )
)

(defun ACT:read-version (/ root path handle line)
  (if (setq root (ACT:root-dir))
    (setq path (findfile (strcat root "\\VERSION")))
  )
  (if path (setq handle (open path "r")))
  (if handle
    (progn
      (setq line (read-line handle))
      (close handle)
    )
  )
  (if line (vl-string-trim " \t\r\n" line) "?")
)

(defun ACT:load-module (name / root path)
  (if (setq root (ACT:root-dir))
    (setq path (findfile (strcat root "\\src\\" name)))
  )
  (if path
    (load path)
    (prompt (strcat "\nACT missing module: " name))
  )
)

;; Load every .lsp file in the lenh folder. A broken file is reported and
;; skipped so the remaining files still load.
(defun ACT:load-commands (/ root folder act-files act-file act-result)
  (if (setq root (ACT:root-dir))
    (progn
      (setq folder (strcat root "\\lenh"))
      (setq act-files (vl-directory-files folder "*.lsp" 1))
      (foreach act-file (if act-files (vl-sort act-files '<))
        (setq act-result (vl-catch-all-apply 'load (list (strcat folder "\\" act-file))))
        (if (vl-catch-all-error-p act-result)
          (prompt (strcat "\nHVLisp loi file " act-file ": " (vl-catch-all-error-message act-result)))
        )
      )
    )
    (prompt (strcat "\nHVLisp: khong tim thay thu muc cai. Hay chep bo lenh vao " ACT:install-dir))
  )
)

(setq ACT:version (ACT:read-version))

(ACT:load-module "act-core.lsp")
(ACT:load-module "act-coord.lsp")
(ACT:load-module "act-export.lsp")
(ACT:load-module "act-import.lsp")
(ACT:load-module "act-elev.lsp")
(ACT:load-module "act-chainage.lsp")
(ACT:load-module "act-interp.lsp")
(ACT:load-module "act-profile.lsp")
(ACT:load-commands)
(prompt (strcat "\nHVLisp v" ACT:version " - go HVHELP de xem lenh"))
(princ)
