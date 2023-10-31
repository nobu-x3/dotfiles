rm -rf ~/.config/i3

# general deps
./install-deps.sh

# optional stuff
yay -S armcord spotify obsidian-bin obs-studio-tytan652 python310 python-pip python-neovim --noconfirm

# fonts
sudo pacman -S noto-fonts noto-fonts-emoji ttf-joypixels gnu-free-font ttf-cascadia-code ttf-fira-mono ttf-fira-code ttc-iosevka ttf-jetbrains-mono --noconfirm
yay -S ttf-ms-fonts ttf-noto-emoji-monocrome bdf-font ttf-google-fonts-git ttf-mononoki all-repository-fonts --noconfirm

# symlinks to configs
./create-links.sh

./install-oh-my-zsh.sh

# comment out if no vulkan
./vulkan-stuff.sh

reboot
