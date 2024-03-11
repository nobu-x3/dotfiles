# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="amuse"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git z zsh-autosuggestions man fzf)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
export EDITOR='emacs'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias ls='ls --color=auto'
alias hx='helix'
alias la='ls -la'
alias jai='jai-linux'

#alias nvim='neovide'
export VISUAL="nvim"
export CC=/usr/bin/clang
export CXX=/usr/bin/clang++
# export CC=/usr/bin/gcc
# export CXX=/usr/bin/g++
eval $(keychain --eval --quiet id_rsa)
# export PATH="$HOME/zig-bootstrap/out/zig-x86_64-linux-gnu-native/bin:$PATH"
export PATH="$HOME/zig:$PATH"
export PATH="$HOME/zls/zig-out/bin:$PATH"
export PATH=$PATH:/home/nobu/.spicetify
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/Odin:$PATH"
export PATH="$HOME/ols:$PATH"
export ODIN_ROOT="$HOME/Odin"
export PATH="$HOME/Qt:$HOME/Qt/Tools/QtCreator/bin:$HOME/Qt/Tools/QtDesignStudio/bin:$PATH"
export PATH="$HOME/.config/emacs/bin:$PATH"
export PATH="$HOME/jai_compiler/bin:$PATH"
export PATH="$HOME/jai_compiler/Jails/bin:$PATH"
export PATH="$HOME/Jails/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
#export VULKAN_SDK="/nix/store/nzz1vdvyp3b00gvc6hq48g2z5yml9zjx-vulkan-headers-1.3.249:$VULKAN_SDK"
#export VULKAN_SDK="/nix/store/hrvx0baps9xhfzb2lv71di4hbqvcr7fz-vulkan-loader-1.3.249:$VULKAN_SDK"
#export VULKAN_SDK="/nix/store/kinq12hayd004zfwmndfif158m7hd8fp-vulkan-validation-layers-1.3.249:$VULKAN_SDK"
#export VULKAN_SDK="/nix/store/17za1lldv8jxgfa493n5d7kjhpirx46r-vulkan-validation-layers-1.3.249-headers:$VULKAN_SDK"
#export VULKAN_SDK="/nix/store/76zm8yzdyd2hvwrja38c0s2fngxxdbn0-vulkan-extension-layer-1.3.248:$VULKAN_SDK"
source ~/vulkanSDK/setup-env.sh
source ~/.p4config
