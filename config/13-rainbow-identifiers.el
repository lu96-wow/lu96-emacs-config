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
  ;; 自定义 15 色 foreground，保证相邻索引颜色差异大
  (let ((colors
         '("#e6194b"  ;; 1.  红
           "#3cb44b"  ;; 2.  绿
           "#4363d8"  ;; 3.  蓝
           "#f58231"  ;; 4.  橙
           "#911eb4"  ;; 5.  紫
           "#42d4f4"  ;; 6.  青
           "#f032e6"  ;; 7.  粉
           "#bfef45"  ;; 8.  黄绿
           "#469990"  ;; 9.  墨绿
           "#dcbeff"  ;; 10. 淡紫
           "#9a6324"  ;; 11. 棕
           "#800000"  ;; 12. 深红
           "#aaffc3"  ;; 13. 浅绿
           "#808000"  ;; 14. 橄榄
           "#000075"))) ;; 15. 深蓝
    (dotimes (i (length colors))
      (set-face-foreground
       (intern (format "rainbow-identifiers-identifier-%d" (1+ i)))
       (nth i colors)))))

;; ── 全局激活 ──
(defun my/rainbow-identifiers-activate ()
  "在非排除列表的 mode 中启用标识符着色。"
  (unless (memq major-mode my/rainbow-identifiers-exclude-modes)
    (rainbow-identifiers-mode 1)))

(add-hook 'after-change-major-mode-hook #'my/rainbow-identifiers-activate)

(provide '13-rainbow-identifiers)
;;; 13-rainbow-identifiers.el ends here
