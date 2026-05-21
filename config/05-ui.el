;; ============================================================
;; 05-ui.el — 界面设置
;; ============================================================

;; 行号（全局开启）
(global-display-line-numbers-mode 1)
;; 不要行号在终端下显示为红色（避免混乱）
(setq display-line-numbers-width-start t)

;; ── 颜色主题（暗色） ──
;; modus-vivendi 是 Emacs 官方暗色主题，高对比度、护眼
(load-theme 'modus-vivendi t)

;; 高亮当前行（淡灰色）
(global-hl-line-mode 1)
(set-face-background 'hl-line "#333333")

;; 显示列号
(column-number-mode 1)

;; 显示时间（可选）
(display-time-mode 1)

;; 匹配括号高亮
(show-paren-mode 1)
(setq show-paren-delay 0
      show-paren-style 'mixed)

;; 关闭烦人的备份文件（~ 文件）
(setq make-backup-files nil
      auto-save-default nil)

;; 关闭自动创建 lock 文件
(setq create-lockfiles nil)

;; 最近打开的文件
(recentf-mode 1)
(setq recentf-max-menu-items 20)

(provide '05-ui)
;;; 05-ui.el ends here
