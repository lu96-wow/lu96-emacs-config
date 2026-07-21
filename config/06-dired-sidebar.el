;; ============================================================
;; 06-dired-sidebar.el — 文件树侧边栏（neotree）
;; ============================================================
;;
;; 侧边栏内：
;;   RET / TAB     — 打开文件 / 展开折叠目录
;;   S-RET         — 在另一窗口打开
;;   g / q         — 刷新 / 关闭
;;   H             — 切换 dotfiles 显隐
;;   A             — 最大化/还原宽度
;;   C-c C-n       — 创建文件或目录
;;   C-c C-d       — 删除文件或目录
;;   C-c C-r       — 重命名
;;   C-c C-c       — 将当前目录设为根
;;   U             — 回上级目录

(use-package neotree
  :ensure t
  :defer t
  :bind ("C-c ." . neotree-toggle)
  :init
  (setq neo-theme 'arrow
        neo-smart-open t
        neo-show-hidden-files nil
        neo-window-width 28)
  :config
  (set-face-attribute 'neo-dir-link-face nil :foreground "#6c9eF5")
  (set-face-attribute 'neo-root-dir-face nil :foreground "#5b8aDc" :weight 'bold))

(provide '06-dired-sidebar)
;;; 06-dired-sidebar.el ends here
