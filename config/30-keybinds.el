;; ============================================================
;; 30-keybinds.el — 快捷键配置
;; ============================================================

;; ── 自定义键位帮助 ──
(defun my/display-keybindings-help ()
  "显示自定义快捷键帮助。"
  (interactive)
  (with-current-buffer (get-buffer-create "*键位帮助*")
    (let ((inhibit-read-only t))
      (erase-buffer)
      (insert
       "自定义快捷键帮助\n"
       "────────────────────────\n\n"
       "基本操作\n"
       "  C-q              退出 Emacs\n"
       "  C-i              开始选中\n"
       "  C-S-c            复制（终端）\n\n"
       "文件与窗口\n"
       "  C-c f            打开文件\n"
       "  C-c -            上下分割\n"
       "  C-c \\            左右分割\n\n"
       "窗口导航\n"
       "  C-c w 方向键      移到相邻窗口\n"
       "  C-c w d          删除当前窗口\n\n"
       "Buffer（C-c b）\n"
       "  C-c b l          列出所有\n"
       "  C-c b n / p      下/上一个\n"
       "  C-c b d / u      下/上一个（备用）\n"
       "  C-c b k          删除\n"
       "  C-c b b          切换\n\n"
       "搜索\n"
       "  C-c [            向前\n"
       "  C-c ]            向后\n\n"
       "文件树（C-c . 开关）\n"
       "  RET / TAB        打开 / 展开折叠\n"
       "  S-RET            另一窗口打开\n"
       "  C-c C-n          新建文件/目录\n"
       "  C-c C-d          删除\n"
       "  C-c C-r          重命名\n"
       "  C-c C-c          当前目录设为根\n"
       "  U                回上级目录\n"
       "  g                刷新\n"
       "  q                关闭\n"
       "  H                切换 dotfiles 显隐\n"
       "  A                最大化\n\n"
       "工作区（C-c t）\n"
       "  C-c t ← / →     上一个 / 下一个\n"
       "  C-c t n          新建\n"
       "  C-c t d          关闭\n"
       "  C-c t r          重命名\n\n"
       "CUA（选中后）\n"
       "  C-c              复制\n"
       "  C-x              剪切\n"
       "  C-v              粘贴\n"
       "  C-z              撤销\n\n"
       "编程\n"
       "  M-o              切换 dotfiles 显隐（dired）\n\n"
       "q 或 C-c h 关闭\n")
      (goto-char (point-min)))
    (special-mode)
    (setq buffer-read-only t
          mode-line-format nil)
    (pop-to-buffer (current-buffer))))

;; C-c h 显示帮助
(global-set-key (kbd "C-c h") 'my/display-keybindings-help)

;; ── CUA 模式 ──
;; 有选中区域时：C-c = 复制, C-x = 剪切, C-v = 粘贴
;; 无选中区域时：C-c 仍可作为模式前缀键使用
(cua-mode 1)

;; 额外快捷键
(global-set-key (kbd "C-q") 'save-buffers-kill-terminal)   ;; C-q = 退出
(global-set-key (kbd "C-i") 'set-mark-command)              ;; C-i = 开始选中
(global-set-key (kbd "C-S-c") 'kill-ring-save)              ;; C-S-c = 复制（终端备用）

;; ── 搜索快捷键 ──
(global-set-key (kbd "C-c [") 'isearch-backward)            ;; C-c [ = 向前查找
(global-set-key (kbd "C-c ]") 'isearch-forward)             ;; C-c ] = 向后查找

;; ── 窗口导航（WindMove）──
(require 'windmove)
(global-set-key (kbd "C-c w <left>")  'windmove-left)
(global-set-key (kbd "C-c w <right>") 'windmove-right)
(global-set-key (kbd "C-c w <up>")    'windmove-up)
(global-set-key (kbd "C-c w <down>")  'windmove-down)
(global-set-key (kbd "C-c w d")       'my/delete-window)

;; ── 工作区导航（C-c t 前缀）──
(defvar my-tab-map (make-sparse-keymap)
  "Keymap for tab/workspace operations under C-c t.")
(define-key my-tab-map (kbd "<left>")  'tab-previous)
(define-key my-tab-map (kbd "<right>") 'tab-next)
(define-key my-tab-map (kbd "n")       'tab-new)
(define-key my-tab-map (kbd "d")       'tab-close)
(define-key my-tab-map (kbd "r")       'tab-rename)
(global-set-key (kbd "C-c t") my-tab-map)

;; ── 安全删除窗口 ──
(defun my/delete-window ()
  "安全地删除当前窗口。"
  (interactive)
  (if (one-window-p)
      (message "已是最后一个窗口，无法删除")
    (delete-window)))

;; ── Buffer 操作前缀键（C-c b）──
(defvar my-buffer-map (make-sparse-keymap)
  "Keymap for buffer operations under C-c b.")

(define-key my-buffer-map (kbd "l") 'ibuffer)
(define-key my-buffer-map (kbd "u") 'previous-buffer)
(define-key my-buffer-map (kbd "p") 'previous-buffer)
(define-key my-buffer-map (kbd "d") 'next-buffer)
(define-key my-buffer-map (kbd "n") 'next-buffer)
(define-key my-buffer-map (kbd "k") 'kill-buffer)
(define-key my-buffer-map (kbd "b") 'switch-to-buffer)

(global-set-key (kbd "C-c b") my-buffer-map)

;; ── 文件 / 窗口操作 ──
(global-set-key (kbd "C-c f") 'find-file)
(global-set-key (kbd "C-c -") 'split-window-below)
(global-set-key (kbd "C-c \\") 'split-window-right)

(provide '30-keybinds)
;;; 30-keybinds.el ends here
