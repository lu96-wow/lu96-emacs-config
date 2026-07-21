;;; 07-key-hook.el --- 中文括号转英文 + 自动配对 -*- lexical-binding: t; -*-

(defun my/convert-and-pair-brackets ()
  "将中文括号转换为英文，并自动补全右括号"
  (let ((last-char (char-before (point))))
    (cond
     ;; 中文左括号：转换后手动插入右括号
     ((eq last-char ?（)
      (ignore-errors
        (delete-char -1)
        (insert "(")
        (insert ")")
        (backward-char 1)))
     
     ((eq last-char ?）)
      (ignore-errors
        (delete-char -1)
        (insert ")")))
     
     ;; 其他情况，交给 electric-pair-mode 处理
     (t nil))))

;; 替换原来的 hook
(add-hook 'post-self-insert-hook #'my/convert-and-pair-brackets)

(provide '07-key-hook)
;;; 07-key-hook.el ends here
