# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
alias sudo="sudo "
alias vi="vim"
alias grep="grep --color" # grep は常にカラーモードON
alias diff="colordiff"

# history コマンド実行日時を記録するフォーマット
HISTTIMEFORMAT='%Y/%m/%d %H:%M:%S '
HISTSIZE=10000 # 履歴保持件数


