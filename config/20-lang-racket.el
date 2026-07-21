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

;; ── racket-insert-closing 安全补丁 ──
;; racket-mode 在空文件开头按闭括号时，
;; 尝试读取 (point)-2 位置导致 args-out-of-range，
;; 这里提前拦截。
(with-eval-after-load 'racket-parens
  (defun racket-insert-closing (&optional prefix)
    "Insert a matching closing delimiter (安全补丁：处理空缓冲区)。"
    (interactive "P")
    (if (or prefix
            (<= (point) 2)   ;; 缓冲区少于 2 个字符时直接插入
            (and (string= "#\\" (buffer-substring-no-properties
                                 (- (point) 2) (point)))
                 (racket--ppss-string-p (syntax-ppss))))
        (racket--self-insert last-command-event)
      (let* ((open-char  (racket--open-paren #'backward-up-list))
             (close-pair (and open-char (assq open-char racket--matching-parens)))
             (close-char (and close-pair (cdr close-pair))))
        (racket--self-insert (or close-char last-command-event))))))

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
    ;; ── company 补全弹出框 ──
    ;; 调用 racket-xp 的 completion-at-point 后端显示候选列表
    (company-mode 1)
    ;; ── eldoc 参数/文档提示 ──
    (eldoc-mode 1)
    ;; ── 可选辅助（装了才启用） ──
    ;; paredit / smartparens：结构化括号编辑
    (when (fboundp 'paredit-mode)
      (paredit-mode 1))
    ;; quack：Racket 专属缩进与文档集成
    (when (fboundp 'quack-mode)
      (quack-mode 1))
    ;; Racket 缩进：2 空格
    (setq-local indent-tabs-mode nil
                tab-width 2
                racket-indent-offset 2))
  (setq racket-program "racket"))

;; ── company 补全框架配置 ──
(use-package company
  :ensure t
  :defer t
  :config
  ;; Racket 补全靠 company-capf（调用 racket-xp 的补全函数）
  (setq company-backends '(company-capf
                           company-dabbrev-code
                           company-dabbrev)
        company-idle-delay 0.2
        company-minimum-prefix-length 1
        company-selection-wrap-around t))

;; ── Geiser（可选，与 racket-mode 互补） ──
(use-package geiser-racket
  :ensure geiser
  :defer t
  :after racket-mode
  :config
  (setq geiser-racket-binary "racket"))

(provide '20-lang-racket)
;;; 20-lang-racket.el ends here
