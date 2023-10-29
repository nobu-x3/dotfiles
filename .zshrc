        export CC=/run/current-system/sw/bin/clang
        export CXX=/run/current-system/sw/bin/clang++
        alias ls='ls --color=auto'
        alias hx='helix'
        #alias nvim='neovide'
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
