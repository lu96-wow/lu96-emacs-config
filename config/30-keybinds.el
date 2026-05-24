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

;; ── 搜索快捷键 ──
(global-set-key (kbd "C-c [") 'isearch-backward)            ;; C-c < = 向前查找
(global-set-key (kbd "C-c ]") 'isearch-forward)             ;; C-c > = 向后查找

;; ── DiredSidebar 侧边栏 ──
(global-set-key (kbd "C-c .") 'dired-sidebar-toggle-sidebar)  ;; C-c . = 切换侧边栏（终端友好）

;; ── 窗口导航（WindMove）──
(require 'windmove)
(global-set-key (kbd "C-c w <left>")  'windmove-left)   ;; C-c w ←  = 移到左边窗口
(global-set-key (kbd "C-c w <right>") 'windmove-right)  ;; C-c w →  = 移到右边窗口
(global-set-key (kbd "C-c w <up>")    'windmove-up)     ;; C-c w ↑  = 移到上方窗口
(global-set-key (kbd "C-c w <down>")  'windmove-down)   ;; C-c w ↓  = 移到下方窗口
(global-set-key (kbd "C-c w d")       'my/delete-window)  ;; C-c w d  = 安全删除当前窗口

;; ── 安全删除窗口（避免最后一个窗口报错）──
(defun my/delete-window ()
  "安全地删除当前窗口。
如果当前是最后一个窗口，则不会删除，仅显示提示信息。"
  (interactive)
  (if (one-window-p)
      (message "已是最后一个窗口，无法删除")
    (delete-window)))

;; ── Buffer 操作前缀键（C-c b）──
;; C-c b 现为前缀键，所有 buffer 操作均在其下
(defvar my-buffer-map (make-sparse-keymap)
  "Keymap for buffer operations under C-c b.")

(define-key my-buffer-map (kbd "l") 'ibuffer)                ;; C-c b l = 列出所有 Buffer（ibuffer）
(define-key my-buffer-map (kbd "u") 'previous-buffer)        ;; C-c b u = 切换到上一个 buffer（↑）
(define-key my-buffer-map (kbd "p") 'previous-buffer)        ;; C-c b p = 切换到上一个 buffer（Prev）
(define-key my-buffer-map (kbd "d") 'next-buffer)            ;; C-c b d = 切换到下一个 buffer（↓）
(define-key my-buffer-map (kbd "n") 'next-buffer)            ;; C-c b n = 切换到下一个 buffer（Next）
(define-key my-buffer-map (kbd "k") 'kill-buffer)            ;; C-c b k = 删除当前 buffer（Kill）
(define-key my-buffer-map (kbd "b") 'switch-to-buffer)       ;; C-c b b = 交互式切换 buffer

(global-set-key (kbd "C-c b") my-buffer-map)                 ;; C-c b 前缀键

;; ── 文件 / 窗口操作（C-c 前缀快捷）──
(global-set-key (kbd "C-c f") 'find-file)                    ;; C-c f = 打开文件
(global-set-key (kbd "C-c -") 'split-window-below)           ;; C-c - = 垂直创建新窗口（左右分） 
(global-set-key (kbd "C-c \\") 'split-window-right)          ;; C-c \ = 水平分隔创建新窗口（上下分）

(provide '30-keybinds)
;;; 30-keybinds.el ends here
