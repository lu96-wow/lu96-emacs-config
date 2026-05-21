;; ============================================================
;; 13-rainbow-identifiers.el — 标识符彩色着色（通用，所有文件）
;; ============================================================
;;
;; 安装：M-x package-install RET rainbow-identifiers RET
;; 新机器首次启动自动通过 :ensure t 安装
;;
;; 效果：
;;   每个标识符/单词按名字哈希分配固定颜色
;;   同名同色，异名异色，一眼看出相同变量/函数的使用位置
;;
;; 排除列表：
;;     (push 'dired-mode my/rainbow-identifiers-exclude-modes)
;; ============================================================

(defvar my/rainbow-identifiers-exclude-modes
  '(dired-mode help-mode special-mode ibuffer-mode compilation-mode)
  "不启用标识符着色的 major mode 列表。")

(use-package rainbow-identifiers
  :ensure t
  :defer t
  :init
  ;; 输入后延迟着色，避免打字时单词颜色不停跳变
  ;; 0.3 秒 = 停顿时才刷新颜色
  (setq jit-lock-defer-time 0.3)
  :config
  ;; 插件硬编码只创建 15 个 face（第 16+ 个循环到第 1 个）
  (setq rainbow-identifiers-face-count 15)
  (setq rainbow-identifiers-choose-face-function
        'rainbow-identifiers-predefined-choose-face)
  ;; 基于 VS Code Dark+ (Codium 默认) 配色调色板
  ;; 色彩柔和，不刺眼不暗淡
  (progn
    (setq my/rainbow-ids-colors
          '("#9CDCFE"  ;; 1.  浅蓝（变量）
            "#DCDCAA"  ;; 2.  米黄（函数）
            "#4EC9B0"  ;; 3.  青绿（类型）
            "#C586C0"  ;; 4.  淡紫（关键字）
            "#CE9178"  ;; 5.  橙褐（字符串）
            "#569CD6"  ;; 6.  蓝（常量）
            "#b5cea8"  ;; 7.  草绿（数字）
            "#d7ba7d"  ;; 8.  暖黄（转义）
            "#d16969"  ;; 9.  暗红（正则）
            "#4FC1FF"  ;; 10. 亮蓝（枚举）
            "#C8C8C8"  ;; 11. 浅灰（标签）
            "#6A9955"  ;; 12. 灰绿（注释）
            "#c8a070"  ;; 13. 驼色
            "#a888c8"  ;; 14. 灰紫
            "#70b8a8")) ;; 15. 苍青
    (dotimes (i (length my/rainbow-ids-colors))
      (set-face-foreground
       (intern (format "rainbow-identifiers-identifier-%d" (1+ i)))
       (nth i my/rainbow-ids-colors)))))

;; ── 全局激活 ──
(defun my/rainbow-identifiers-activate ()
  "在非排除列表的 mode 中启用标识符着色。"
  (unless (memq major-mode my/rainbow-identifiers-exclude-modes)
    (rainbow-identifiers-mode 1)))

(add-hook 'after-change-major-mode-hook #'my/rainbow-identifiers-activate)

(provide '13-rainbow-identifiers)
;;; 13-rainbow-identifiers.el ends here
