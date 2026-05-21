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
  ;; 颜色数量（更多色彩，更亮）
  (setq rainbow-identifiers-face-count 16)
  ;; CIE Lab 空间生成颜色，色彩均匀分布
  (setq rainbow-identifiers-choose-face-function
        'rainbow-identifiers-cie-l*a*b*-choose-face
        rainbow-identifiers-cie-l*a*b*-lightness 65   ;; 亮度提高
        rainbow-identifiers-cie-l*a*b*-saturation 55  ;; 饱和度提高
        rainbow-identifiers-cie-l*a*b*-color-count 16))

;; ── 全局激活 ──
(defun my/rainbow-identifiers-activate ()
  "在非排除列表的 mode 中启用标识符着色。"
  (unless (memq major-mode my/rainbow-identifiers-exclude-modes)
    (rainbow-identifiers-mode 1)))

(add-hook 'after-change-major-mode-hook #'my/rainbow-identifiers-activate)

(provide '13-rainbow-identifiers)
;;; 13-rainbow-identifiers.el ends here
