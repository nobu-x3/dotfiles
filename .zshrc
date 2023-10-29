# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/nobu/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
#
# If not running interactively, don't do anything

alias ls='ls --color=auto'
alias hx='helix'
#alias nvim='neovide'
PS1='[\u@\h \W]\$ '

export VISUAL="helix"

# export PATH="$HOME/zig-bootstrap/out/zig-x86_64-linux-gnu-native/bin:$PATH"
export PATH="$HOME/zig:$PATH"
export PATH="$HOME/zls/zig-out/bin:$PATH"
export PATH=$PATH:/home/nobu/.spicetify
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/Odin:$PATH"
export PATH="$HOME/ols:$PATH"
export DEBUGINFOD_URLS="https://debuginfod.archlinux.org"
export ODIN_ROOT="$HOME/Odin"
source ~/vulkanSDK/setup-env.sh
