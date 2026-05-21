;; ============================================================
;; 30-keybinds.el — 快捷键配置
;; ============================================================

;; ── 全局快捷键 ──

;; 将 M-x 替换为更现代的 M-x（已经默认）
;; 常用命令的快捷方式
(global-set-key (kbd "C-c r") 'recentf-open-files)    ;; 打开最近文件
(global-set-key (kbd "C-c f") 'find-file)              ;; 查找文件
(global-set-key (kbd "C-c b") 'switch-to-buffer)       ;; 切换缓冲区

;; ── 代码相关 ──
(global-set-key (kbd "C-c i") 'indent-region)          ;; 缩进选中区域
(global-set-key (kbd "C-c c") 'comment-or-uncomment-region) ;; 注释/取消注释

;; ── 编译运行 ──
(global-set-key (kbd "C-c C-c") 'compile)              ;; 编译
(setq compile-command "make -k ")                      ;; 默认编译命令

;; ── 窗口管理 ──
(global-set-key (kbd "C-c w 1") 'delete-other-windows) ;; 只保留当前窗口
(global-set-key (kbd "C-c w 2") 'split-window-below)   ;; 水平分屏
(global-set-key (kbd "C-c w 3") 'split-window-right)   ;; 垂直分屏
(global-set-key (kbd "C-c w 0") 'delete-window)        ;; 关闭当前窗口

(provide '30-keybinds)
;;; 30-keybinds.el ends here
