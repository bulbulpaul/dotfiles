;; 環境切り分け用の定義作成 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (defvar is_emacs22 (equal emacs-major-version 22))
(defvar is_emacs23 (equal emacs-major-version 23))
(defvar is_emacs24 (equal emacs-major-version 24))
;; (defvar is_window-sys (not (eq (symbol-value 'window-system) nil)))
;; Mac全般のとき
(defvar is_mac (or (eq window-system 'mac) (featurep 'ns)))
;; Cocoa Emacsのとき
;; (defvar is_cocoa (and is_mac is_emacs23 is_window-sys))
;; (defvar is_inline-patch (eq (boundp 'mac-input-method-parameters) t))
;; (defvar is_darwin (eq system-type 'darwin))

;; gnu/linuxの時
(defvar is_linux (eq system-type 'gnu/linux))

;; Win全般の時
(defvar is_win (or is_cygwin is_winnt))
