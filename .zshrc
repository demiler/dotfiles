concd () {
  cd $(fd ".*" ~/contests/sem6 -t l -t d -E ".git" -E "__pycache__" | fzf)
}

ccd () {
  cd $(fd ".*" $1 -t d -E .git | fzf)
}

grdir() {
  nemo "$(pwd)" 2> /dev/null &|
}

export LC_ALL=en_US.UTF-8

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
export EDITOR=nvim
export PATH=$PATH:"$HOME/bin":"$HOME/.local/bin"

export ZSH="/home/demiler/.oh-my-zsh"

#export TERM="xterm-256color"
ZSH_THEME="robbyrussell"

DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(
  fd
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
)

# Load Git completion
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)

autoload -Uz compinit && compinit
source $ZSH/oh-my-zsh.sh

###################| ALIASES |###################
alias copyworkkey="cat ~/.ssh/work.pub | copy"
alias psgrep="ps -aux | grep -v grep | grep"
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
alias vimrc="vim ~/.config/nvim/init.vim"
alias seczsh="ZSH_SECURE=1 zsh"
alias ip="ip -c"
alias workvpn="doas openvpn --config $HOME/.ovpn/demiler.ovpn"
alias zshrc="vim ~/.zshrc"
alias copy="xclip -selection clipboard"
alias paste="xclip -selection clipboard -o"
alias vim=nvim
alias cdb='cd ..'
alias lt="ls -tr"
alias gits="git status"
alias gitl="git --no-pager log --oneline"
alias gitlh="gitl --color=always | head"
alias py="python3"
alias npy="py -i -c'import numpy as np'"
alias pdf="zathura"
###################| VIM MODE |###################
bindkey -v #enable vim mode

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward

#vim_ins_mode="%{%F{37}%}[I]%f%}"
#vim_cmd_mode="%{%F{41}%}[N]%f%}"
#vim_mode=$vim_ins_mode
#function zle-keymap-select {
  #vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
  #zle reset-prompt
#}
#zle -N zle-keymap-select

precmd() { RPROMPT="" }
function zle-line-init zle-keymap-select {
   VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]%  %{$reset_color%}"
   RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
   zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

export KEYTIMEOUT=1

if [ ! -z $ZSH_SECURE ]; then
  tmpHistFile=$(mktemp)
  cat $HISTFILE > $tmpHistFile
  HISTFILE=$tmpHistFile
  echo "Secure mode, saving history to temp file: $tmpHistFile"
  trap "{ rm $tmpHistFile; echo exiting secure mode; }" EXIT
  SEC_PROMPT="%F{240}[secure] %f"
fi

# another prompt symbol ❯
#%F{37} - green color
#%F{41} - blue color
#PROMPT='${vim_mode} %B%F{104}%c%f%b $(git_prompt_info)%(?:%F{208}❯%f :%F{196}❯%f )'
PROMPT='$SEC_PROMPT%F{240}@seamoth %f%B%F{104}%c%f%b $(git_prompt_info)%(?:%F{208}\$%f :%F{196}\$%f )'

#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_OPTS='--layout=reverse --extended'
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
