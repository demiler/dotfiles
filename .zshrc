concd () {
  cd $(fd ".*" ~/contests -t d -E ".git" | fzf)
}
ccd () {
  cd $(fd ".*" $1 -t d -E .git | fzf)
}
grdir() {
  nemo "$(pwd)" 2> /dev/null &|
}

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
export EDITOR=nvim
export PATH=$PATH:"/home/demiler/bin"
#export PAGER=most

# Path to your oh-my-zsh installation.
export ZSH="/home/demiler/.oh-my-zsh"

#export TERM="xterm-256color"
ZSH_THEME="robbyrussell"
#ZSH_THEME="agnoster"
#ZSH_THEME="powerlevel9k/powerlevel9k"
#POWERLEVEL9K_MODE="nerdfont-complete"

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
alias genpass='pwgen -1 -s 20 | tr -d "\n" | copy && echo $(copy -o)'
alias copy="xclip -selection clipboard"
alias cvim="/usr/bin/vim"
alias vim=nvim
alias vimrc="vim ~/.config/nvim/init.vim"
alias zshrc="vim ~/.zshrc"
alias cdb='cd ..'
alias yd=yandex-disk
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
alias calc="python3 -q"
alias img='xviewer'
alias prac='ssh s02190692@prac.cs.msu.ru'
alias ready="spd-say 'ready' -p -100 -r -50"
alias cmd="fc -ln | tac | fzf | tr -d '\n' | copy"
alias fd="fdfind"
alias gits="git status"
alias lt="ls -t | head"
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

#%F{37} - green color
#%F{41} - blue color
#PROMPT='${vim_mode} %B%F{104}%c%f%b $(git_prompt_info)%(?:%F{208}❯%f :%F{196}❯%f )'
PROMPT='%B%F{104}%c%f%b $(git_prompt_info)%(?:%F{208}❯%f :%F{196}❯%f )'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='--layout=reverse --extended'
