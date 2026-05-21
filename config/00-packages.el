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

;; 首次使用手动刷新：M-x package-refresh-contents
;; 安装包：M-x package-install RET <包名>

(provide '00-packages)
;;; 00-packages.el ends here
