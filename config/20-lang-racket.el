;; ============================================================
;; 20-lang-racket.el — Racket 开发环境
;;
;; 文件名匹配规则：
;;   .rkt*     — 匹配 .rkt、.rkt.history 等变体
;;   .rktl     — Racket 库文件
;;   .rktd     — Racket 数据文件
;;   .rktx     — Racket 示例文件
;;   .scrbl    — Scribble 文档
;;
;; 前提：需先安装 racket-mode
;;   M-x package-install RET racket-mode RET
;; ============================================================

(use-package racket-mode
  :ensure t
  :defer t
  :mode ("\\.rkt\\(\\..*\\)?\\'"  ;; .rkt 及 .rkt.xxx 衍生文件
         "\\.rktl\\'"
         "\\.rktd\\'"
         "\\.rktx\\'"
         "\\.scrbl\\'")
  :hook (racket-mode . my/racket-setup)
  :config
  (defun my/racket-setup ()
    "Racket 模式挂钩：开启辅助功能。"
    ;; ── Racket 官方语法补全 ──
    ;; racket-xp 基于 Racket 宏展开和静态分析，
    ;; 提供语义补全、绑定高亮、定义跳转
    (require 'racket-xp)
    (racket-xp-mode 1)
    ;; 参数提示
    (eldoc-mode 1)
    ;; 括号编辑（需安装 paredit）
    (when (fboundp 'paredit-mode)
      (paredit-mode 1))
    ;; 彩虹括号（需安装 rainbow-delimiters）
    (when (fboundp 'rainbow-delimiters-mode)
      (rainbow-delimiters-mode 1))
    ;; 通用补全（需安装 company，与 racket-xp 互补）
    (when (fboundp 'company-mode)
      (company-mode 1))
    ;; Racket 缩进用 2 空格（社区惯例）
    (setq-local indent-tabs-mode nil
                tab-width 2))
  ;; Racket 交互环境路径
  (setq racket-program "racket"))

(provide '20-lang-racket)
;;; 20-lang-racket.el ends here
