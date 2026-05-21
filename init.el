;; ============================================================
;; init.el — Emacs 主配置文件入口
;; 模块化加载各文件，按语言分类
;; ============================================================

;; 此时 Debian 系统 site-start.d 已加载完毕，可以安全开启 debug
(let ((debug-mode (bound-and-true-p my/debug-mode)))
  (when debug-mode
    (setq debug-on-error t
          warning-minimum-level :debug)))

;; 将 config/ 目录加入加载路径
(add-to-list 'load-path (expand-file-name "config" user-emacs-directory))

;; ── 加载顺序（数字前缀控制优先级） ──
(require '00-packages)        ;; 包管理
(require '05-ui)              ;; 界面设置
(require '10-editor)          ;; 编辑器行为
;; (require '15-completion)   ;; 补全框架（需要时取消注释并安装 company）
(require '20-lang-racket)     ;; Racket
(require '21-lang-cc)         ;; C/C++
(require '30-keybinds)        ;; 快捷键

;; 自定义设置存储文件
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; 启动后恢复 GC 正常阈值
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 100 1024 1024)
                  gc-cons-percentage 0.1)))

(provide 'init)
;;; init.el ends here
