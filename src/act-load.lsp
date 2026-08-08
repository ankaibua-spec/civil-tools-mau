;;; AutoLISP Civil Tools Community loader.
;;; Copyright (C) 2026 Truong Hoa and contributors.
;;; SPDX-License-Identifier: GPL-3.0-or-later

(vl-load-com)

(defun ACT:root-dir (/ path)
  (setq path (findfile "act-load.lsp"))
  (if path
    (vl-filename-directory path)
  )
)

(defun ACT:load-module (name / path)
  (setq path (strcat (ACT:root-dir) "\\" name))
  (if (findfile path)
    (load path)
    (prompt (strcat "\nACT missing module: " name))
  )
)

(ACT:load-module "act-core.lsp")
(ACT:load-module "act-coord.lsp")
(ACT:load-module "act-export.lsp")
(ACT:load-module "act-elev.lsp")
(ACT:load-module "act-profile.lsp")
(prompt "\nAutoLISP Civil Tools Community loaded. Commands: CTCOORD, CTEXPORT, CTELEV, CTPROFILE.")
(princ)
