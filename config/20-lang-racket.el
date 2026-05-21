;; ============================================================
;; 20-lang-racket.el — Racket 开发环境
;;
;; 参考官方指南：https://docs.racket-lang.org/guide/Emacs.html
;;
;; 文件名匹配：
;;   .rkt*     — 匹配 .rkt、.rkt.history 等衍生文件
;;   .rktl     — 库文件
;;   .rktd     — 数据文件
;;   .rktx     — 示例文件
;;   .scrbl    — Scribble 文档
;;
;; 依赖：M-x package-install RET racket-mode RET
;; 可选增强：
;;   M-x package-install RET quack RET        — 缩进/文档增强
;;   M-x package-install RET geiser RET       — 集成式 REPL
;;   M-x package-install RET scheme-complete  — eldoc 补全
;;   apt install emacs-goodies-el             — Debian 版 quack
;; ============================================================

(use-package racket-mode
  :ensure t
  :defer t
  :mode ("\\.rkt\\(\\..*\\)?\\'"  ;; .rkt 及 .rkt.xxx
         "\\.rktl\\'"
         "\\.rktd\\'"
         "\\.rktx\\'"
         "\\.scrbl\\'")
  :hook (racket-mode . my/racket-setup)
  :config
  (defun my/racket-setup ()
    "Racket 模式挂钩。"
    ;; ── 官方推荐：racket-xp 语法补全 ──
    ;; racket-mode 自带的基于宏展开的语义补全
    (require 'racket-xp)
    (racket-xp-mode 1)
    ;; ── eldoc 参数/文档提示 ──
    (eldoc-mode 1)
    ;; ── 可选辅助（装了才启用） ──
    ;; paredit / smartparens：结构化括号编辑
    (when (fboundp 'paredit-mode)
      (paredit-mode 1))
    ;; rainbow-delimiters：彩虹括号（按嵌套深度着色）
    (when (fboundp 'rainbow-delimiters-mode)
      (rainbow-delimiters-mode 1))
    ;; quack：Racket 专属缩进与文档集成
    (when (fboundp 'quack-mode)
      (quack-mode 1))
    ;; scheme-complete：上下文补全（与 eldoc 联动）
    (when (fboundp 'scheme-define-intelligent-completion)
      (scheme-define-intelligent-completion))
    ;; Racket 缩进：2 空格
    (setq-local indent-tabs-mode nil
                tab-width 2))
  (setq racket-program "racket"))

;; ── Geiser（可选，与 racket-mode 互补） ──
(use-package geiser-racket
  :ensure geiser
  :defer t
  :after racket-mode
  :config
  (setq geiser-racket-binary "racket"))

(provide '20-lang-racket)
;;; 20-lang-racket.el ends here
