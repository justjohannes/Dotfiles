#-------------------------------------------------------
#       General settings
#-------------------------------------------------------

HISTFILE=/home/simplyhazel/.config/zsh/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
zstyle :compinstall filename '/home/johannes/.zshrc'

autoload -Uz compinit
compinit

# some useful options (man zshoptions)
setopt autocd extendedglob nomatch menucomplete
setopt interactive_comments
stty stop undef		# Disable ctrl-s to freeze terminal.
zle_highlight=('paste:none')

# beeping is annoying
unsetopt BEEP

# completions
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
# zstyle ':completion::complete:lsof:*' menu yes select
zmodload zsh/complist
# compinit
_comp_options+=(globdots)		# Include hidden files.

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Correction
setopt correctall

# Colors
autoload -Uz colors && colors

# Useful Functions
source "$ZDOTDIR/zsh-functions"

# Plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "hlissner/zsh-autopair"
zsh_add_plugin "romkatv/powerlevel10k"
#zsh_add_completion "esc/conda-zsh-completion" false
# For more plugins: https://github.com/unixorn/awesome-zsh-plugins
# More completions https://github.com/zsh-users/zsh-completions

#-------------------------------------------------------
#       Zsh prompt and color script
#-------------------------------------------------------

# zsh prompt
source /home/simplyhazel/.config/zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

#-------------------------------------------------------
#       Alias
#-------------------------------------------------------

alias ls='exa -ahl --icons'

#-------------------------------------------------------
#       Path
#-------------------------------------------------------

#Rofi scripts
export PATH="$PATH:$HOME/.config/rofi/scripts"

#JetBrains-toolbox path
PATH="/home/johannes/.local/share/JetBrains/Toolbox:${PATH}" 

#GOPATH 
export PATH="$PATH:$HOME/go/bin"
export GOPATH=$HOME/go
