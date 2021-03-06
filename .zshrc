# ----export----
# 日本語を使用
export LANG=ja_JP.UTF-8
export PATH="/usr/local/bin:$PATH"

# zplug
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

# JAVA
JAVA_OPTS="-Dfile.encoding=UTF-8"
export JAVA_OPTS

# go
export GOPATH=$HOME/.go

JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_121.jdk/Contents/Home"
export PATH=$JAVA_HOME/bin:$PATH

# ----Global----
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# ----setopt----
# 他のターミナルとヒストリーを共有
setopt share_history
# ヒストリーに重複を表示しない
setopt histignorealldups
# コマンドミスを修正
setopt correct
# Ctrl+sのロック, Ctrl+qのロック解除を無効にする
setopt no_flow_control
# 先頭がスペースならヒストリーに追加しない。
setopt hist_ignore_space
# show japanese character
setopt print_eight_bit
# 自動cd
setopt auto_cd
# cd一覧表示
setopt auto_pushd
# Beepオフ
setopt nolistbeep

setopt prompt_subst

# emacs key bind
bindkey -e

# ----prompt theme----
autoload -U promptinit; promptinit
prompt pure

# ----zstyle----
zstyle :compinstall filename '/Users/$USER/.zshrc'
# 補完後、メニュー選択モードになり左右キーで移動が出来る
zstyle ':completion:*:default' menu select=2

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ----auto load----
# 補完
autoload -Uz compinit
compinit

# 色を使用
autoload -Uz colors
colors

# lsカラー表示
export LSCOLORS=ExFxCxdxBxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
# 補完をカラーに
zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'

# ----alias----
alias ls='ls -G'
alias lst='ls -ltr -G'
alias l='ls -ltra -G'
alias la='ls -la -G'
alias ll='ls -l -G'
alias diff='diff -u'
alias g='git'
alias ga='git add'
alias gaa='git add -all'
alias gcb='git checkout -b'
alias gcm='git commit -m'
alias gca='git commit -ammend'
alias gsb='git status -sb'
alias gss='git status -s'
alias gsi='git submodule init'
alias glog='git log --oneline --decorate --graph'
alias gloga='git log --oneline --decorate --graph --all'
alias gd='git diff'
alias e='emacs'

# ----bind key----
# Ctrl+rでヒストリーのインクリメンタルサーチ、Ctrl+sで逆順
bindkey '^r' history-incremental-pattern-search-backward
bindkey '^s' history-incremental-pattern-search-forward

# ----zplug----
# zsh-syntax-highlighting
zplug "zsh-users/zsh-syntax-highlighting", defer:3
# コマンド補完
zplug "zsh-users/zsh-completions"
# auto suggest
zplug "zsh-users/zsh-autosuggestions"
# anyframe
zplug "mollifier/anyframe"

zplug load

# ----bind key----
bindkey '^xb' anyframe-widget-cdr
bindkey '^x^b' anyframe-widget-checkout-git-branch

bindkey '^xr' anyframe-widget-execute-history
bindkey '^x^r' anyframe-widget-execute-history

bindkey '^xp' anyframe-widget-put-history
bindkey '^x^p' anyframe-widget-put-history

bindkey '^xg' anyframe-widget-cd-ghq-repository
bindkey '^x^g' anyframe-widget-cd-ghq-repository

bindkey '^xk' anyframe-widget-kill
bindkey '^x^k' anyframe-widget-kill

bindkey '^xi' anyframe-widget-insert-git-branch
bindkey '^x^i' anyframe-widget-insert-git-branch

bindkey '^xf' anyframe-widget-insert-filename
bindkey '^x^f' anyframe-widget-insert-filename

# ---any frame setting----
# expressly specify to use peco
zstyle ":anyframe:selector:" use peco
# expressly specify to use percol
zstyle ":anyframe:selector:" use percol
# expressly specify to use fzf
zstyle ":anyframe:selector:" use fzf

# pyenv init
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
# rbenv
eval "$(rbenv init -)"
export PATH="/usr/local/opt/node@6/bin:$PATH"

# dirnev
eval "$(direnv hook zsh)"

if [ ~/.zshrc -nt ~/.zshrc.zwc ]; then
  zcompile ~/.zshrc
fi

