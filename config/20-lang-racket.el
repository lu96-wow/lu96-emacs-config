;; ============================================================
;; 20-lang-racket.el — Racket 模式
;; 根据 .rkt .scrbl .rktl 后缀自动加载
;;
;; 前提：需先安装 racket-mode
;;   M-x package-install RET racket-mode RET
;; ============================================================

;; ── racket-mode ──
(use-package racket-mode
  :defer t
  :mode ("\\.rkt\\'"  "\\.rktl\\'" "\\.rktd\\'"
         "\\.scrbl\\'" "\\.rktx\\'")
  :hook (racket-mode . my/racket-setup)
  :config
  (defun my/racket-setup ()
    "Racket 模式挂钩：开启辅助功能。"
    ;; 括号编辑（需安装 paredit）
    (when (fboundp 'paredit-mode)
      (paredit-mode 1))
    ;; 彩虹括号（需安装 rainbow-delimiters）
    (when (fboundp 'rainbow-delimiters-mode)
      (rainbow-delimiters-mode 1))
    ;; 参数提示
    (eldoc-mode 1)
    ;; 补全（需安装 company）
    (when (fboundp 'company-mode)
      (company-mode 1))
    ;; Racket 缩进用 2 空格（社区惯例）
    (setq-local indent-tabs-mode nil
                tab-width 2))
  (setq racket-program "racket"))

(provide '20-lang-racket)
;;; 20-lang-racket.el ends here
