#
# ~/.bashrc
#
export PATH="$HOME/.emacs.d/bin:$PATH"

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

alias emacs="emacsclient -c -a 'emacs'"
