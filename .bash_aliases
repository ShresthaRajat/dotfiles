globalias() {
   if [[ $LBUFFER =~ ' [A-Z0-9]+$' ]]; then
     zle _expand_alias
     zle expand-word
   fi
   zle self-insert
}

alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias jn='jupyter notebook'
alias glog='git log --oneline'
alias nvsmi='watch -n 0.5 nvidia-smi'
alias thinkmorse='sudo modprobe ec_sys write_support=1 | sudo python ~/thinkmors
e.py'
alias gits='git status'
alias gs='git status'
alias gp='git pull'
alias gc='git push'
alias r='figlet Rajat Shrestha | lolcat'
alias nf='neofetch'
alias nstp='netstat -tulpn'
#alias -g L="| less"
#alias -g GG="google.com"
#alias -g G="| grep"
alias dockerps='docker ps --format $FORMAT'
alias dockerpsl='docker ps -l --format $FORMAT'
alias python=python3
alias pip=pip3
alias gkey='gsettings list-recursively | grep -e org.gnome.desktop.wm.keybinding
s -e org.gnome.settings-daemon.plugins.media-keys -e org.gnome.settings-daemon.p
lugins.power | sort'
alias lsR='ls -R'
alias flk='flake8 --statistics'
alias lsl='ls -al'
alias pl='pip list'

