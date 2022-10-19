bindkey -e

# Rajat's config for the Zoomer Shell burrowed from luke smith

# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
setopt prompt_subst

# Git stauts indicator
autoload -Uz vcs_info
zstyle ':vcs_info:*' stagedstr 'M' 
zstyle ':vcs_info:*' unstagedstr 'M' 
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' actionformats '%F{5}(%F{2}%b%F{3}|%F{1}%a%F{5})%f '
zstyle ':vcs_info:*' formats \
  '%F{5}%F{2}(%b)%F{5} %F{2}%c%F{3}%u%f'
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
zstyle ':vcs_info:*' enable git 
+vi-git-untracked() {
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
  [[ $(git ls-files --other --directory --exclude-standard | sed q | wc -l | tr -d ' ') == 1 ]] ; then
  hook_com[unstaged]+='%F{1}??%f'
fi
}
precmd () { vcs_info }

# use custom prompt with the git status indicator
PROMPT='%B%{$fg[yellow]%}%n%b%{$fg[white]%}@%{$fg[cyan]%}%M%B %{$fg[magenta]%}%~%{$reset_color%}${vcs_info_msg_0_}%f $ '


setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.

# History in conf/zsh/zhistory directory:
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.config/zsh/.zsh_history

# Load aliases and shortcuts if existent.
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shortcutrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shortcutrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/aliases" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/aliases"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zshnameddirrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zshnameddirrc"

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# bind Ctrl+A to terminal calculator
bindkey -s '^a' 'bc -l\n'


# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Load syntax highlighting and zsh auto suggestions; should be last.
# download these modules in usr/share/plugins/
# sudo mkdir /usr/share/zsh/plugins
# sudo git clone https://github.com/zsh-users/zsh-autosuggestions.git /usr/share/zsh/plugins/zsh-autosuggestions
# sudo git clone https://github.com/zdharma/fast-syntax-highlighting.git /usr/share/zsh/plugins/fast-syntax-highlighting

source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh 

source ~/.config/aliasrc
export PATH="$PATH:$HOME/.local/bin"

# export NVM_DIR="/home/rajat/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# add PATH
export PATH=$PATH:$HOME/.pulumi/bin
export PYENV_ROOT="$HOME/.pyenv"

command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(ssh-agent -s)"



[[ $commands[kubectl] ]] && source <(kubectl completion zsh)
