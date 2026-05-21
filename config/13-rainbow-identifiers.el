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
  :config
  ;; 颜色数量（默认 26 种色调循环）
  (setq rainbow-identifiers-face-count 12)
  ;; 选择颜色生成方式：CIE Lab 空间，色彩更均匀
  (setq rainbow-identifiers-choose-face-function
        'rainbow-identifiers-cie-l*a*b*-choose-face
        rainbow-identifiers-cie-l*a*b*-lightness 55
        rainbow-identifiers-cie-l*a*b*-saturation 45
        rainbow-identifiers-cie-l*a*b*-color-count 12))

;; ── 全局激活 ──
(defun my/rainbow-identifiers-activate ()
  "在非排除列表的 mode 中启用标识符着色。"
  (unless (memq major-mode my/rainbow-identifiers-exclude-modes)
    (rainbow-identifiers-mode 1)))

(add-hook 'after-change-major-mode-hook #'my/rainbow-identifiers-activate)

(provide '13-rainbow-identifiers)
;;; 13-rainbow-identifiers.el ends here
