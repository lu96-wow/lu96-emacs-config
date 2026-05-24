;; ============================================================
;; 06-dired-sidebar.el — 侧边栏文件管理器
;; ============================================================

(use-package dired-sidebar
  :ensure t
  :after (dired)
  :commands (dired-sidebar-toggle-sidebar)
  :config
  ;; ── 外观设置 ──
  (setq dired-sidebar-theme 'nerb)              ;; 简洁风格（nil=默认, 'nerb=简洁）
  (setq dired-sidebar-width 28)                  ;; 侧边栏宽度（字符数）
  (setq dired-sidebar-no-delete-char t)          ;; 禁止在侧边栏按 d 标记删除
  (setq dired-sidebar-no-subdir-control t)       ;; 不显示子目录控制按钮
  (setq dired-sidebar-use-custom-font t)         ;; 使用自定义字体（适配图标）

  ;; ── 行为设置 ──
  (setq dired-sidebar-files-icon '(display))     ;; 显示文件类型图标
  (setq dired-sidebar-subtree-line-prefix "  ")  ;; 子目录缩进
  (setq dired-sidebar-sort-alphabetically t)     ;; 按字母排序

  ;; ── 侧边栏打开后自动定位到当前文件所在目录 ──
  (setq dired-sidebar-follow-file-after-toggle t)

  ;; ── 右键菜单（可选） ──
  (setq dired-sidebar-mouse-button-action 'find-file)  ;; 鼠标点击打开文件

  ;; ── 关闭侧边栏后回到原窗口 ──
  ;;     修复：原窗口被关闭时不再尝试切回，避免 "Attempt to select deleted window"
  (advice-add 'dired-sidebar-toggle-sidebar :around
              (lambda (orig-fun &rest args)
                (let ((cur-win (selected-window)))
                  (apply orig-fun args)
                  ;; 仅当 cur-win 仍然存活 且 焦点切到了侧边栏时才切回去
                  (when (and (window-live-p cur-win)
                             (not (eq (selected-window) cur-win)))
                    (select-window cur-win)))))

  ;; ── 打开文件时自动刷新侧边栏 ──
  (add-hook 'find-file-hook 'dired-sidebar-follow-file)
)

(provide '06-dired-sidebar)
;;; 06-dired-sidebar.el ends here