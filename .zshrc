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

# Docker
export DOCKER_HOST=tcp://$(boot2docker ip 2>/dev/null):2375


# -------------------------------------
# history
# -------------------------------------
# 履歴ファイルの保存先
export HISTFILE=${HOME}/.zsh_history

# メモリに保存される履歴の件数
export HISTSIZE=1000

# 履歴ファイルに保存される履歴の件数
export SAVEHIST=100000

# 重複を記録しない
setopt hist_ignore_dups


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
alias grep="grep --color -I --exclude='*.git-*' --exclude='entries' --exclude='*/cache/*'"

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
function chpwd() { ll }

# iTerm2のタブ名を変更する
function title {
    echo -ne "\033]0;"$*"\007"
}


#
# net-tools コマンドの非推奨対応
#
###net_tools_deprecated_message () {
###  echo -n 'net-tools コマンドはもう非推奨ですよ？おじさんなんじゃないですか？ '
###}
###
###arp () {
###  net_tools_deprecated_message
###  echo 'Use `ip n`'
###}
###ifconfig () {
###  net_tools_deprecated_message
###  echo 'Use `ip a`, `ip link`, `ip -s link`'
###}
###iptunnel () {
###  net_tools_deprecated_message
###  echo 'Use `ip tunnel`'
###}
###iwconfig () {
###  echo -n 'iwconfig コマンドはもう非推奨ですよ？おじさんなんじゃないですか？ '
###  echo 'Use `iw`'
###}
###nameif () {
###  net_tools_deprecated_message
###  echo 'Use `ip link`, `ifrename`'
###}
####netstat () {
####  net_tools_deprecated_message
####  echo 'Use `ss`, `ip route` (for netstat -r), `ip -s link` (for netstat -i), `ip maddr` (for netstat -g)'
####}
###route () {
###  net_tools_deprecated_message
###  echo 'Use `ip r`'
###}

#
# peco
#
function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history


#
# snippets
# @see http://blog.glidenote.com/blog/2014/06/26/snippets-peco-percol/
#
function peco-snippets() {
    local SNIPPETS=$(grep -v "^#" ~/.snippets | peco --query "$LBUFFER" | tr -d "\n" | pbcopy)
    zle clear-screen
}
zle -N peco-snippets
bindkey '^x^x' peco-snippets


#
# google cloud SDK
#
# The next line updates PATH for the Google Cloud SDK.
source "${HOME}/google-cloud-sdk/path.zsh.inc"

# The next line enables zsh completion for gcloud.
source "${HOME}/google-cloud-sdk/completion.zsh.inc"
