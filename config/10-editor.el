;; ============================================================
;; 10-editor.el — 编辑器通用行为
;; ============================================================

;; ── 基础编辑 ──
(setq-default indent-tabs-mode nil)       ;; 使用空格缩进
(setq-default tab-width 2)                ;; 缩进宽度 4
(setq-default fill-column 80)             ;; 自动换行列宽

;; 选中文本后输入直接替换
(delete-selection-mode 1)

;; 代码折叠
(setq truncate-lines t)                   ;; 不自动折行

;; ── 文件处理 ──
(setq-default buffer-file-coding-system 'utf-8-unix)
(prefer-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)

;; 当文件外部被修改时自动重载
(global-auto-revert-mode 1)

;; ── 搜索 ──
(setq lazy-highlight-initial-delay 0)     ;; 即时高亮搜索结果

;; ── 语法着色性能 ──
(setq fast-but-imprecise-scrolling t)     ;; 快速滚动时跳过着色，停下再补（Emacs 29+）
(setq jit-lock-defer-time 0.05)           ;; 滚动停止 0.05 秒后再着色，减少卡顿

;; ── 记住光标位置 ──
(save-place-mode 1)

;; ── 编码检测 ──
(setq locale-coding-system 'utf-8)
(ignore-errors (set-terminal-coding-system 'utf-8))
(ignore-errors (set-keyboard-coding-system 'utf-8))

(provide '10-editor)
;;; 10-editor.el ends here
