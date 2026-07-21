;; ============================================================
;; 22-lang-lisp.el — Common Lisp 开发环境 (SLIME)
;;
;; 前端：SLIME — Superior Lisp Interaction Mode for Emacs
;;   提供 REPL、调试器、代码导航、补全等完整 IDE 功能
;; 后端：SBCL（已通过 apt 安装）
;;   若需切换其它实现，修改 inferior-lisp-program 即可
;;
;; 文件名匹配：
;;   .lisp .lsp .cl  — 标准 Common Lisp 后缀
;;
;; 首次启动 Emacs 时 SLIME 会通过 :ensure t 自动安装
;; ============================================================

(use-package slime
  :ensure t
  :defer t
  :mode ("\\.lisp\\'" . lisp-mode)
  :hook (lisp-mode . my/lisp-setup)
  :init
  ;; 在 SLIME 加载前设定，避免依赖顺序问题
  (setq inferior-lisp-program "sbcl"
        slime-contribs '(slime-fancy
                         slime-company))
  :config
  ;; ── SLIME 配置 ──
  (setq slime-net-coding-system 'utf-8-unix
        slime-complete-symbol-function 'slime-fuzzy-complete-symbol
        slime-lisp-implementations
        '((sbcl ("sbcl" "--dynamic-space-size" "2048"))
          ))
  ;; 默认使用 sbcl
  (setq slime-default-lisp 'sbcl)

  (defun my/lisp-setup ()
    "Common Lisp 模式挂钩。"
    ;; ── 缩进 ──
    (setq-local indent-tabs-mode nil
                tab-width 2
                lisp-indent-offset 2)
    ;; ── 补全 ──
    (company-mode 1)
    ;; ── 文档提示 ──
    (eldoc-mode 1)
    ;; ── 可选：paredit / smartparens ──
    (when (fboundp 'paredit-mode)
      (paredit-mode 1))
    ;; ── 首次打开 .lisp 文件时自动启动 SLIME ──
    (unless (slime-current-connection)
      (condition-case nil
          (slime)
        (error (message "SLIME 启动失败，检查 sbcl 是否安装"))))))

;; ── SLIME 专用 company 后端 ──
(use-package slime-company
  :ensure t
  :defer t
  :after (slime company)
  :config
  (setq slime-company-completion 'all
        slime-company-after-completion 'slime-company-just-one-space))

(provide '22-lang-lisp)
;;; 22-lang-lisp.el ends here
