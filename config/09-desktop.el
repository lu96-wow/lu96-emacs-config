;; ============================================================
;; 09-desktop.el — 自动保存/恢复窗口布局
;; ============================================================
;;
;; 退出时自动保存，再次启动自动恢复。每个目录独立布局。
;; 最多保留 30 个，超出自动清理。

(setq desktop-restore-eager 10
      desktop-load-locked-desktop t
      desktop-dirname (expand-file-name "desktops" user-emacs-directory)
      desktop-path (list desktop-dirname))

(make-directory desktop-dirname t)

;; ── 文件名：当前目录 MD5 ──
(setq desktop-base-file-name
      (concat (secure-hash 'md5 (expand-file-name default-directory)) ".desktop"))

;; ── 清理：只保留最近 30 个 ──
(defun my/desktop-cleanup ()
  (let* ((files (ignore-errors
                  (directory-files desktop-dirname t "\\.desktop\\'" t)))
         (sorted (and files
                      (sort files (lambda (a b)
                                    (> (float-time (or (nth 5 (file-attributes a)) 0))
                                       (float-time (or (nth 5 (file-attributes b)) 0))))))))
    (dolist (f (nthcdr 30 sorted))
      (ignore-errors (delete-file f)))))

(add-hook 'desktop-save-hook #'my/desktop-cleanup)

;; ── 启用（自动加载 + 退出自动保存） ──
(desktop-save-mode 1)

;; ── 每次保存时更新文件名（防止 default-directory 变化）──
(add-hook 'desktop-save-hook
          (lambda ()
            (setq desktop-base-file-name
                  (concat (secure-hash 'md5 (expand-file-name default-directory))
                          ".desktop"))))

(provide '09-desktop)
;;; 09-desktop.el ends here
