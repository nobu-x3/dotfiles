#
# ~/.bashrc
#
export PATH="$HOME/.emacs.d/bin:$PATH"
export CC=/usr/bin/clang
export CXX=/usr/bin/clang++
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

if ! pgrep -u "$USER" ssh-agent > /dev/null; then
	ssh-agent -t 8h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! -f "$SSH_AUTH_SOCK" ]]; then
	source "$XDG_RUNTIME_DIR/ssh-agent.env" > /dev/null
fi

[[ $- == *i* ]] && . /usr/share/blesh/ble.sh

export VISUAL="nvim"
# alias nvim="neovide"
alias emacs="emacsclient -c -a 'emacs'"
. "$HOME/.cargo/env"

export PATH="$HOME/zig:$PATH"
export PATH="$HOME/git/zls/zig-out/bin:$PATH"
