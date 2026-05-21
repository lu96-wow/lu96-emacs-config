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

