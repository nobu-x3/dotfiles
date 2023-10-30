# general deps
sudo pacman -S git neovim alacritty picom feh gtk3 htop pulseaudio dunst polybar neofetch xclip llvm-libs=16.0.6-1 llvm=16.0.6-1 clang=16.0.6-1 cmake=3.27.7-2 zsh=5.9-4 ripgrep=13.0.0-3 fzf=0.43.0-1 tmux=3.3_a-7 curl amdvlk keychain renderdoc glslang vulkan-validation-layers=1.3.268.0-1 lldb --noconfirm
yay -S nvim-packer-git obsidian-bin slack-desktop  --noconfirm

# optional stuff
yay -S armcord spotify obsidian-bin obs-studio-tytan652 python310 --noconfirm

# fonts
sudo pacman -S noto-fonts noto-fonts-emoji ttf-joypixels gnu-free-font ttf-cascadia-code ttf-fira-mono ttf-fira-code ttc-iosevka ttf-jetbrains-mono --noconfirm
yay -S ttf-ms-fonts ttf-noto-emoji-monocrome bdf-font ttf-google-fonts-git ttf-mononoki all-repository-fonts --noconfirm

# symlinks to configs
ln -s ~/dotfiles/.config/i3 ~/.config/i3
ln -s ~/dotfiles/.config/alacritty ~/.config/alacritty
ln -s ~/dotfiles/.config/polybar ~/.config/polybar
ln -s ~/dotfiles/.config/rofi ~/.config/rofi
ln -s ~/dotfiles/.config/dunst ~/.config/dunst
ln -s ~/dotfiles/.config/nvim ~/.config/nvim
ln -s ~/dotfiles/.config/tmux ~/.config/tmux
ln -s ~/dotfiles/.config/gtk-4.0 ~/.config/gtk-4.0
ln -s ~/dotfiles/.config/gtk-3.0 ~/.config/gtk-3.0
ln -s ~/dotfiles/.config/gtk-2.0 ~/.config/gtk-2.0

chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# after reboot
rm -rf ~/.zshrc
ln -s ~/dotfiles/.zshrc ~/.zshrc
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# comment out if no vulkan
./vulkan-stuff.sh
