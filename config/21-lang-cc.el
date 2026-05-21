;; ============================================================
;; 21-lang-cc.el — C/C++ 模式（内置 cc-mode，无需安装）
;; 根据 .c .h .cpp .hpp .cc .cxx 后缀自动加载
;; ============================================================

(use-package cc-mode
  :defer t
  :mode ("\\.c\\'"   "\\.h\\'"
         "\\.cpp\\'" "\\.hpp\\'"
         "\\.cc\\'"  "\\.cxx\\'"
         "\\.hh\\'"  "\\.hxx\\'")
  :hook ((c-mode . my/c-mode-setup)
         (c++-mode . my/c++-mode-setup))
  :config
  (defun my/c-mode-setup ()
    "C 模式挂钩。"
    (c-set-style "linux")
    (setq-local indent-tabs-mode t
                tab-width 8
                c-basic-offset 8)
    (setq-local comment-start "/* "
                comment-end " */"
                comment-start-skip "/\\*+[ \t]*")
    (eldoc-mode 1))

  (defun my/c++-mode-setup ()
    "C++ 模式挂钩。"
    (c-set-style "stroustrup")
    (setq-local indent-tabs-mode nil
                tab-width 4
                c-basic-offset 4)
    (eldoc-mode 1)))

(setq c-default-style
      '((java-mode . "java")
        (awk-mode  . "awk")
        (other     . "linux")))

(provide '21-lang-cc)
;;; 21-lang-cc.el ends here
