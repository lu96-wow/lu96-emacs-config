;; ============================================================
;; 12-rainbow-delimiters.el — 彩色括号（通用，所有文件）
;; ============================================================
;;
;; 安装：M-x package-install RET rainbow-delimiters RET
;; 新机器首次启动自动通过 :ensure t 安装
;;
;; 效果：
;;   所有文件（包括无后缀等任意文件）括号按嵌套深度 9 色循环着色
;;
;; 排除列表：
;;   如有不需要彩色括号的 mode，加到这个列表里：
;;     (push 'dired-mode my/rainbow-exclude-modes)
;; ============================================================

;; ── 排除列表（不想生效的 major mode 加在这里） ──
(defvar my/rainbow-exclude-modes
  '(dired-mode
    help-mode
    special-mode
    ibuffer-mode
    compilation-mode)
  "不启用彩色括号的 major mode 列表。")

;; ── rainbow-delimiters ──
(use-package rainbow-delimiters
  :ensure t
  :defer t
  :init
  ;; 确保语法高亮在所有模式下开启（彩色括号依赖 font-lock）
  (global-font-lock-mode 1)
  :config
  ;; 9 色暗色系调色板（低亮度，护眼）
  ;; 注：插件硬编码只创建 9 层 face，第 10+ 层自动循环复用 1-9
  (defvar my/rainbow-colors
    '(;; 深度 1-9
      "#d08770"  ;; 1. 暖褐
      "#7cb884"  ;; 2. 草绿
      "#7898c8"  ;; 3. 雾蓝
      "#c884c0"  ;; 4. 淡紫
      "#c8b870"  ;; 5. 土黄
      "#70b8a8"  ;; 6. 苍青
      "#a888c8"  ;; 7. 灰紫
      "#c8a070"  ;; 8. 驼色
      "#70a870") ;; 9. 灰绿
    "彩虹括号配色方案（暗色系，9 色，更深自动循环）")

  (dotimes (i 9)
    (set-face-foreground
     (intern (format "rainbow-delimiters-depth-%d-face" (1+ i)))
     (nth i my/rainbow-colors))))

;; ── 全局激活：所有 major mode 变更后自动启用，排除列表除外 ──
(defun my/rainbow-delimiters-activate ()
  "在非排除列表的 mode 中启用彩色括号。"
  (unless (memq major-mode my/rainbow-exclude-modes)
    (rainbow-delimiters-mode 1)))

(add-hook 'after-change-major-mode-hook #'my/rainbow-delimiters-activate)

(provide '12-rainbow-delimiters)
;;; 12-rainbow-delimiters.el ends here
