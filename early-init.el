;; ============================================================
;; early-init.el — Emacs 29+ 早期初始化
;; ============================================================

;; ── Debug 开关 ──
;; 配置/调试阶段设为 t，报错窗口、警告、backtrace 全开
;; 稳定后可设为 nil 或直接删掉这行
(setq my/debug-mode t)

;; ── 启动加速（仅稳定后生效） ──
(unless my/debug-mode
  ;; 关闭工具栏、滚动条、菜单栏（GUI 模式）
  (push '(menu-bar-lines . 0) default-frame-alist)
  (push '(tool-bar-lines . 0) default-frame-alist)
  (push '(vertical-scroll-bars) default-frame-alist)

  ;; 关闭启动画面
  (setq inhibit-startup-screen t)

  ;; 关闭错误提示音
  (setq ring-bell-function 'ignore)

  ;; 关闭 GC 警告（减少卡顿）
  (setq gc-cons-threshold most-positive-fixnum
        gc-cons-percentage 0.6))

;; Debug 模式下：打开错误回溯、警告完整显示
(when my/debug-mode
  (setq debug-on-error t
        debug-on-signal t
        warning-minimum-level :debug))

;; ============================================================
;; early-init.el — Emacs 29+ 早期初始化（界面加速）
;; 在 GUI 框架和包系统加载前执行
;; ============================================================

;; 关闭工具栏、滚动条、菜单栏（GUI 模式）
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

;; 关闭启动画面
(setq inhibit-startup-screen t)

;; 关闭文件开头的声音提示
(setq ring-bell-function 'ignore)

;; 关闭 GC 警告（减少卡顿）
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

