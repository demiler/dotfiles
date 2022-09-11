krypt() {
  [ $# -lt 3 ] && echo "Usage: $0 <key file> <out name> <file1> [file2] [file3] ..." && return 1
  tar -zcf - ${@:3} | gpg --batch --passphrase-file "$1" -c --cipher-algo AES256 -o "$2"
}

dkrypt() {
  [ $# -lt 2 ] && echo "Usage: $0 <key file> <krypt file1> [file2]..." && return 1
  for f in ${@:2}; do
    gpg --batch --passphrase-file "$1" -d --cipher-algo AES256 "$f" | tar -zxf -
  done
}

concd () {
  cd $(fd ".*" ~/contests/sem6 -t l -t d -E ".git" -E "__pycache__" | fzf)
}

ccd () {
  cd $(fd ".*" $1 -t d -E .git | fzf)
}

grdir() {
  nemo "$(pwd)" 2> /dev/null &|
}

sshrc() {
  [ $# -eq 1 ] && nvim ~/.ssh/config.d/$1 || nvim ~/.ssh/config
}

#source /etc/profile.d/vte.sh
export LC_ALL=en_US.UTF-8

export SIDEQUEST="/home/demiler/.config/SideQuest/backups"
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
export EDITOR=nvim
export PATH=$PATH:"$HOME/bin":"$HOME/.local/bin"
#export PAGER=most

export ZSH="/home/demiler/.oh-my-zsh"

#export TERM="xterm-256color"
ZSH_THEME="robbyrussell"

#ZSH_THEME="random"
#ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

#DISABLE_AUTO_TITLE="true"
#ENABLE_CORRECTION="true"
#COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

#HIST_STAMPS="mm/dd/yyyy"

#ZSH_CUSTOM=/path/to/new-custom-folder

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

#export MANPATH="/usr/local/man:$MANPATH"

#Compilation flags
#export ARCHFLAGS="-arch x86_64"

###################| ALIASES |###################
alias workvpn="doas openvpn --config .ovpn/demiler.ovpn"
alias psgrep="ps -aux | grep -v grep | grep"
alias bell="notify-send -a 'Shell bell' -h 'string:desktop-entry:org.kde.konsole' DONE"
alias seczsh="ZSH_SECURE=1 zsh"
alias ip="ip -c"
alias vimrc="vim ~/.config/nvim/init.vim"
alias zshrc="vim ~/.zshrc"
alias genpass='pwgen -1 -s 20 | tr -d "\n" | copy && echo $(copy -o)'
alias copy="xclip -selection clipboard"
alias paste="xclip -o -selection clipboard"
alias cvim="/usr/bin/vim"
alias vim=nvim
alias cdb='cd ..'
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
alias calc="python3 -q"
alias img='eog'
alias ready="spd-say 'ready' -p -100 -r -50"
alias cmd="fc -ln | tac | fzf | tr -d '\n' | copy"
#alias fd="fdfind"
alias lt="ls -t --color=always | head"
alias gits="git status"
alias gitl="git --no-pager log --oneline"
alias gitlh="gitl --color=always | head"
#alias mpv="mpv --gpu-context=x11egl"
alias mpva="[ ! -d .watch_later ] && mkdir .watch_later; mpv --profile=anime ."
alias mpvc="[ -f mpv.conf ] && mpv --config-dir=. . || echo 'no mpv.conf file found'"
alias py="python3"
alias npy="py -i -c'import numpy as np'"
alias umntmedia="umount /run/media/demiler/*"
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

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  PRCH=">"
else
  PRCH="❯"
fi

if [ ! -z $ZSH_SECURE ]; then
  tmpHistFile=$(mktemp)
  cat $HISTFILE > $tmpHistFile
  HISTFILE=$tmpHistFile
  echo "Secure mode, saving history to temp file: $tmpHistFile"
  trap "{ rm $tmpHistFile; echo exiting secure mode; }" EXIT
  SEC_PROMPT="%F{240}[secure] %f"
fi

#%F{37} - green color
#%F{41} - blue color
#PROMPT='${vim_mode} %B%F{104}%c%f%b $(git_prompt_info)%(?:%F{208}❯%f :%F{196}❯%f )'
PROMPT='$SEC_PROMPT%B%F{104}%c%f%b $(git_prompt_info)%(?:%F{208}$PRCH%f :%F{196}❯%f )'

#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='--layout=reverse --extended'
