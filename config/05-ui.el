;; ============================================================
;; 05-ui.el — 界面设置（兼容终端与 GUI）
;; ============================================================

;; 安全关闭 GUI 元素（在终端中这些函数不存在）
(when (fboundp 'menu-bar-mode)   (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode)   (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

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

;; ── 终端鼠标支持 ──
;; 在 emacs -nw 下启用鼠标点击切换窗口、调整窗口大小等
(unless (display-graphic-p)
  (xterm-mouse-mode 1))

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