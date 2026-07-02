;; ============================================================
;; 06-dired-sidebar.el — 侧边栏文件管理器
;; ============================================================
;;
;; 依赖：dired-sidebar + dired-subtree（自动安装）
;;
;; 快捷键（在侧边栏内生效）：
;;   TAB     — 展开/折叠当前目录（一层）
;;   S-TAB   — 循环展开当前目录（0→1→2→全部→0 层）
;;   RET     — 打开文件 / 进入目录
;;   BACK    — 回到上级目录
;;   ^ / -   — 回到上级目录
;;   C-o     — 在另一窗口打开文件
;;   z M     — 递归展开当前目录下所有子目录
;;   z C     — 递归折叠当前目录下所有子目录
;;   g       — 刷新侧边栏
;;   q       — 隐藏侧边栏

(use-package dired-sidebar
  :ensure t
  :after (dired)
  :commands (dired-sidebar-toggle-sidebar)
  :config
  ;; ── 外观设置 ──
  (setq dired-sidebar-theme 'nerd)               ;; Nerd 风格
  (setq dired-sidebar-width 28)                  ;; 侧边栏宽度（字符数）
  (setq dired-sidebar-no-delete-char t)          ;; 禁止在侧边栏按 d 标记删除
  (setq dired-sidebar-no-subdir-control t)       ;; 不显示子目录控制按钮（由 subtree 接管）
  (setq dired-sidebar-use-custom-font t)         ;; 使用自定义字体（适配图标）

  ;; ── 行为设置 ──
  (setq dired-sidebar-files-icon '(display))     ;; 显示文件类型图标
  (setq dired-sidebar-subtree-line-prefix "  ")  ;; 子目录缩进
  (setq dired-sidebar-sort-alphabetically t)     ;; 按字母排序
  (setq dired-sidebar-cycle-subtree-on-click t)  ;; 鼠标点击目录 = 循环展开

  ;; ── 侧边栏打开后自动定位到当前文件所在目录 ──
  (setq dired-sidebar-follow-file-after-toggle t)

  ;; ── 右键菜单（可选） ──
  (setq dired-sidebar-mouse-button-action 'find-file)

  ;; ══════════════════════════════════════════════════════════
  ;; 子树折叠/展开 — 增强快捷键
  ;; ══════════════════════════════════════════════════════════

  ;; 在 dired-sidebar-mode-map 中追加按键（不会覆盖内置绑定）
  (with-eval-after-load 'dired-sidebar
    (let ((map dired-sidebar-mode-map))

      ;; S-TAB：循环展开（0层→1层→2层→全部→0层）
      (define-key map (kbd "<backtab>") 'dired-subtree-cycle)
      (define-key map (kbd "S-<tab>")   'dired-subtree-cycle)

      ;; Backspace：回到上级目录（类似文件管理器习惯）
      (define-key map (kbd "<backspace>") 'dired-sidebar-up-directory)
      (define-key map (kbd "DEL")        'dired-sidebar-up-directory)

      ;; g：刷新
      (define-key map (kbd "g") 'dired-sidebar-revert)

      ;; q：隐藏侧边栏
      (define-key map (kbd "q") 'dired-sidebar-toggle-sidebar)

      ;; ── z 前缀：批量展开/折叠（类似 org-mode / folded 习惯）──
      ;; z M = 递归展开所有子目录
      (define-key map (kbd "z M")
                  (lambda () (interactive)
                    (dired-subtree-cycle 99)))

      ;; z C = 递归折叠所有子目录
      (define-key map (kbd "z C")
                  (lambda () (interactive)
                    ;; 如果已展开则折叠
                    (while (dired-subtree--is-expanded-p)
                      (dired-subtree-remove))
                    (dired-sidebar-redisplay-icons)))
      ))

  ;; ── 关闭侧边栏后回到原窗口 ──
  (advice-add 'dired-sidebar-toggle-sidebar :around
              (lambda (orig-fun &rest args)
                (let ((cur-win (selected-window)))
                  (apply orig-fun args)
                  (when (and (window-live-p cur-win)
                             (not (eq (selected-window) cur-win)))
                    (select-window cur-win)))))

  ;; ── 打开文件时自动刷新侧边栏 ──
  (add-hook 'find-file-hook 'dired-sidebar-follow-file)
)

(provide '06-dired-sidebar)
;;; 06-dired-sidebar.el ends here