# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
export GREP_OPTIONS='--color=auto' # grep は常にカラーモードON

alias sudo="sudo "
alias diff="colordiff"

# history コマンド実行日時を記録するフォーマット
HISTTIMEFORMAT='%Y/%m/%d %H:%M:%S '
HISTSIZE=10000 # 履歴保持件数


# cd した後にls もついでに実行する
function cdls() {
  # cd がalias でループするので\をつける
  \cd $1;
  ls -l;
}
alias cd=cdls
