;; ============================================================
;; 00-packages.el — 包管理（GNU ELPA 优先）
;; ============================================================

(require 'package)

;; ── 软件源 ──
(setq package-archives
      '(("gnu"       . "https://elpa.gnu.org/packages/")
        ("nongnu"    . "https://elpa.nongnu.org/nongnu/")
        ("melpa"     . "https://melpa.org/packages/"))
      package-archive-priorities
      '(("gnu"    . 10)      ;; GNU 官方源优先
        ("nongnu" . 5)
        ("melpa"  . 0)))     ;; MELPA 优先级最低

;; 初始化包系统
(package-initialize)

;; 首次使用自动刷新包列表
(unless package-archive-contents
  (package-refresh-contents))

;; ── use-package 集成（Emacs 29+ 内置） ──
(require 'use-package)
(setq use-package-verbose nil)

;; 换机器后只需 clone 配置，Emacs 首次启动会自动通过 :ensure t 安装指定包

(provide '00-packages)
;;; 00-packages.el ends here
