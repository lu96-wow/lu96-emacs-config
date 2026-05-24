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
(global-set-key (kbd "C-.") 'dired-sidebar-toggle-sidebar)  ;; C-x C-n = 切换侧边栏

(provide '30-keybinds)
;;; 30-keybinds.el ends here
