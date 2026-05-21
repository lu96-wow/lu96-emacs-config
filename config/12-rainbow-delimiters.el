;; ============================================================
;; 12-rainbow-delimiters.el — 彩色括号（通用，所有编程模式）
;; ============================================================
;;
;; 安装：M-x package-install RET rainbow-delimiters RET
;; 新机器首次启动自动通过 :ensure t 安装
;;
;; 效果：括号按嵌套深度 9 色循环着色，光标高亮匹配括号
;; ============================================================

(use-package rainbow-delimiters
  :ensure t
  :defer t
  :hook ((prog-mode text-mode) . rainbow-delimiters-mode)
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

(provide '12-rainbow-delimiters)
;;; 12-rainbow-delimiters.el ends here
