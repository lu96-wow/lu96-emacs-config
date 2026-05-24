;; ============================================================
;; 30-keybinds.el — 快捷键配置
;; ============================================================

;; ── CUA 模式 ──
;; 有选中区域时：C-c = 复制, C-x = 剪切, C-v = 粘贴
;; 无选中区域时：C-c 仍可作为模式前缀键使用
(cua-mode 1)

;; 额外快捷键
(global-set-key (kbd "C-q") 'save-buffers-kill-terminal)   ;; C-q = 退出
(global-set-key (kbd "C-i") 'set-mark-command)              ;; C-i = 开始选中
(global-set-key (kbd "C-S-c") 'kill-ring-save)              ;; C-S-c = 复制（终端备用）

;; ── DiredSidebar 侧边栏 ──
(global-set-key (kbd "C-c .") 'dired-sidebar-toggle-sidebar)  ;; C-c . = 切换侧边栏（终端友好）

;; ── 窗口导航（WindMove）──
(require 'windmove)
(global-set-key (kbd "C-c w <left>")  'windmove-left)   ;; C-c w ←  = 移到左边窗口
(global-set-key (kbd "C-c w <right>") 'windmove-right)  ;; C-c w →  = 移到右边窗口
(global-set-key (kbd "C-c w <up>")    'windmove-up)     ;; C-c w ↑  = 移到上方窗口
(global-set-key (kbd "C-c w <down>")  'windmove-down)   ;; C-c w ↓  = 移到下方窗口
(global-set-key (kbd "C-c w d")       'delete-window)   ;; C-c w d  = 删除当前窗口

(provide '30-keybinds)
;;; 30-keybinds.el ends here