;; language & code
(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-time-zone-rule "GMT-9")

;; 行番号
(global-linum-mode t)
(setq linum-format "%4d|")

;; beepを消す
(setq visible-bell t)
(setq ring-bell-function 'ignore)

;; "yes or no"を"y or n"に
(fset 'yes-or-no-p 'y-or-n-p)

;; タブは4
(setq-default tab-width 4)
(setq default-tab-width 4)
(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60
                        64 68 72 76 80 84 88 92 96 100 104 108 112 116 120))
;; タブはスペース
(setq-default tab-width 4 indent-tabs-mode nil)

(recentf-mode 1)
;; 最近のファイル500個を保存する
(setq recentf-max-saved-items 1000)
(setq recentf-max-menu-items 300)
(setq recentf-keep '(file-remote-p file-readable-p))
(setq recentf-auto-cleanup 'never)
;; 最近使ったファイルに加えないファイルを正規表現で指定する
;; (setq recentf-exclude '("/TAGS$" "/var/tmp/" "^/[^/:]+:"))
(setq recentf-exclude '("/TAGS$" "/var/tmp/"))

;; バックアップファイルを作らない
(setq backup-inhibited t)

;; オートセーブしない
(setq make-backup-files nil)

;; 保存時にオートセーブファイルを消す
(setq delete-auto-save-files t)

;; バックアップファイルの場所
(setq backup-directory-alist '(("" . "~/.emacs.d/backup")))

;; 前回編集場所を記憶
(load "saveplace")
(setq-default save-place t)

;; 起動画面を表示しない
(setq inhibit-startup-message t)

;; 書き込み不能なファイルはview-modeで開くように
(defadvice find-file
    (around find-file-switch-to-view-file (file &optional wild) activate)
  (if (and (not (file-writable-p file))
           (not (file-directory-p file)))
      (view-file file)
    ad-do-it))

;; 書き込み不能な場合はview-modeを抜けないように
(defvar view-mode-force-exit nil)
(defmacro do-not-exit-view-mode-unless-writable-advice (f)
  `(defadvice ,f (around do-not-exit-view-mode-unless-writable activate)
     (if (and (buffer-file-name)
              (not view-mode-force-exit)
              (not (file-writable-p (buffer-file-name))))
         (message "File is unwritable, so stay in view-mode.")
       ad-do-it)))

(do-not-exit-view-mode-unless-writable-advice view-mode-exit)
(do-not-exit-view-mode-unless-writable-advice view-mode-disable)

;; Emacs 終了時にプロセスを自動で殺す
(defadvice save-buffers-kill-terminal (before my-save-buffers-kill-terminal activate)
  (when (process-list)
    (dolist (p (process-list))
      (set-process-query-on-exit-flag p nil))))

;; 大文字変換を使用する
(put 'upcase-region 'disabled nil)

;; Autosave every 500 typed characters
(setq auto-save-interval 500)

;; スクロール設定
(setq hscroll-step                    1
      scroll-conservatively           10000
      scroll-preserve-screen-position t
      auto-window-vscroll             nil           ; speedup down scroll
      scroll-margin                   5
      redisplay-dont-pause            t             ; this will be default in emacs24
      )

;; 保存時に余計なスペースとタブを取り除く
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; ロケールは C で統一しておく
(setq system-time-locale "C")

;; バッファの終端を明示する
(setq-default indicate-empty-lines t)

;; kill-lineで行が連結したときにインデントを減らす
(defadvice kill-line (before kill-line-and-fixup activate)
  (when (and (not (bolp)) (eolp))
    (forward-char)
    (fixup-whitespace)
    (backward-char)))

;; 同名の .el と .elc があれば新しい方を読み込む
(setq load-prefer-newer t)

;; コマンド履歴を永続的に残す
(setq history-length 250)
(setq desktop-globals-to-save '(extended-command-history
                                desktop-missing-file-warning
                                search-ring
                                regexp-search-ring
                                file-name-history))
;; (setq desktop-files-not-to-save "")
(desktop-save-mode 1)
