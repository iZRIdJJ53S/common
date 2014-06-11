# -------------------------------------
# 環境変数
# -------------------------------------

# SSHで接続した先で日本語が使えるようにする
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# エディタ
export EDITOR=/usr/local/bin/vim

# ページャ
#export PAGER=/usr/local/bin/vimpager
#export MANPAGER=/usr/local/bin/vimpager

# PATH
export PATH=/usr/local/opt/coreutils/libexec/gnubin:$HOME/local/ruby-2.1/bin:/usr/local/bin:$PATH

export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

export DOCKER_HOST=tcp://$(boot2docker ip 2>/dev/null):2375


# -------------------------------------
# ls のカラー設定
# -------------------------------------

# -------------------------------------
# zshのオプション
# -------------------------------------

## 補完機能の強化
autoload -U compinit
compinit

## 入力しているコマンド名が間違っている場合にもしかして：を出す。
setopt correct

# ビープを鳴らさない
setopt nobeep

## 色を使う
setopt prompt_subst

## ^Dでログアウトしない。
setopt ignoreeof

## バックグラウンドジョブが終了したらすぐに知らせる。
setopt no_tify

## 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups

# 補完
## タブによるファイルの順番切り替えをしない
unsetopt auto_menu

# cd -[tab]で過去のディレクトリにひとっ飛びできるようにする
setopt auto_pushd

# ディレクトリ名を入力するだけでcdできるようにする
###setopt auto_cd

# -------------------------------------
# パス
# -------------------------------------

# 重複する要素を自動的に削除
typeset -U path cdpath fpath manpath

path=(
    /usr/local/bin(N-/)
    /usr/local/sbin(N-/)
    $HOME/bin(N-/)
    $path
)

# -------------------------------------
# プロンプト
# -------------------------------------

autoload -U promptinit; promptinit
autoload -Uz colors; colors
autoload -Uz vcs_info
autoload -Uz is-at-least

# begin VCS
zstyle ":vcs_info:*" enable git svn hg bzr
zstyle ":vcs_info:*" formats "(%s)-[%b]"
zstyle ":vcs_info:*" actionformats "(%s)-[%b|%a]"
zstyle ":vcs_info:(svn|bzr):*" branchformat "%b:r%r"
zstyle ":vcs_info:bzr:*" use-simple true

zstyle ":vcs_info:*" max-exports 6

if is-at-least 4.3.10; then
    zstyle ":vcs_info:git:*" check-for-changes true # commitしていないのをチェック
    zstyle ":vcs_info:git:*" stagedstr "<S>"
    zstyle ":vcs_info:git:*" unstagedstr "<U>"
    zstyle ":vcs_info:git:*" formats "(%b) %c%u"
    zstyle ":vcs_info:git:*" actionformats "(%s)-[%b|%a] %c%u"
fi

function vcs_prompt_info() {
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && echo -n " %{$fg[yellow]%}$vcs_info_msg_0_%f"
}
# end VCS

OK="^_^ "
NG="X_X "

PROMPT=""
PROMPT+="%(?.%F{green}$OK%f.%F{red}$NG%f) "
PROMPT+="%F{blue}%~%f"
PROMPT+="\$(vcs_prompt_info)"
PROMPT+="
"
PROMPT+="%% "

RPROMPT="[%*]"

# -------------------------------------
# エイリアス
# -------------------------------------

# -n 行数表示, -I バイナリファイル無視, git関係のファイルを無視
alias grep="grep --color -n -I --exclude='*.git-*' --exclude='entries' --exclude='*/cache/*'"

# ls
if [ -d /usr/local/opt/coreutils/libexec/gnubin ] ; then
  alias ls='ls --color=auto'
  alias ll="ls --color=auto -l"
  alias la="ls --color=auto -la"
else
  export LSCOLORS=gxfxcxdxbxegedabagacad
  alias ls='ls -G'
  alias ll="ls -Gl"
  alias la="ls -Gla"
fi




# tree
alias tree="tree -NC" # N: 文字化け対策, C:色をつける

# updatedb
alias updatedb='sudo /usr/libexec/locate.updatedb'

# diff
alias diff="colordiff"

# -------------------------------------
# キーバインド
# -------------------------------------

# -v == vim, -e == emacs
###bindkey -v
bindkey -e

function cdup() {
   echo
   cd ..
   zle reset-prompt
}
zle -N cdup
bindkey '^K' cdup

bindkey "^R" history-incremental-search-backward

# forward / backword
bindkey "^f" forward-word
bindkey "^b" backward-word
###bindkey "^h" backward-delete-char

# -------------------------------------
# その他
# -------------------------------------

# cdしたあとで、自動的に ls する
function chpwd() { ls -1 }

# iTerm2のタブ名を変更する
function title {
    echo -ne "\033]0;"$*"\007"
}
