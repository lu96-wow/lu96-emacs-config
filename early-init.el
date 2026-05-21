;; ============================================================
;; early-init.el — Emacs 29+ 早期初始化
;; ============================================================

;; ── 包管理：关闭启动时自动激活 ──
;; 改为由 init.el → 00-packages.el 手动调用 package-initialize
;; 避免 Debian Emacs 30.1 的 url-vars 字节码缺陷导致启动报错
(setq package-enable-at-startup nil)

;; ── Debug 开关 ──
;; t    = 开发/调试模式：错误回溯全开，启动加速关闭
;; nil  = 正常模式：静默启动，加速项启用
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

;; 注：debug-on-error 不放在这里，因为 Debian 的 site-start.d
;; 系统文件有字节码缺陷，debug-on-error 会让它们崩掉。
;; debug-on-error 改放到 init.el 开头（Debian 系统文件加载完后）。
