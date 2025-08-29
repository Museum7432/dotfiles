# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
# zstyle :compinstall filename '/home/arch/.zshrc'

# autoload -Uz compinit
# compinit
# End of lines added by compinstall
# autoload -Uz promptinit
# promptinit
# prompt suse

source /usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh

PROMPT='%F{blue}%~ %(?.%F{green}.%F{red})❯%b%f '

alias ls='/usr/bin/ls -hF --color=auto'
alias grep='/usr/bin/grep --color=auto'
alias diff='/usr/bin/colordiff'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I'
# alias conda="micromamba"
# alias open_webui="docker compose -f /home/arch/Projects/open_webui/docker-compose.yml up -d"
# alias workon='conda activate'
alias shell_pixi='pixi shell'

setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_BEEP

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
bindkey "^[[1;5C" forward-word

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh