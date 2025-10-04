#!/bin/bash

set -e

if [ "$EUID" -eq 0 ]; then 
    echo "Please run this script as a normal user, not as root."
    exit 1
fi

keep_sudo_alive() {
    while true; do
        sudo -v
        sleep 50
    done
}

keep_sudo_alive &
KEEP_SUDO_PID=$!

echo "Please enter your password to allow the script to run sudo commands:"
sudo -v

# Update package lists and upgrade existing packages
sudo apt update && sudo apt upgrade -y

# Install required dependencies
sudo apt install -y curl wget cmake git clang zsh cowsay python3 i3 i3-wm rofi tmux neofetch gimp btop python3 \
    virtualbox picom redshift unrar unzip fzf xwallpaper \
    build-essential libssl-dev libcurl4-openssl-dev libxml2-dev libxcb-xinerama0-dev \
    libxcb-icccm4-dev libxcb-randr0-dev libxcb-util0-dev libxcb-xrm-dev libxcb-xkb-dev \
    pkg-config xcb libxcb-image0-dev libjsoncpp-dev libmpdclient-dev libcurl4-openssl-dev \
    libnl-genl-3-dev polybar ffmpeg flameshot jq llvm ncdu node ripgrep xclip -y

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install Kitty
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

# Install Oh My Tmux
git clone https://github.com/gpakosz/.tmux.git ~/.tmux
ln -s -f ~/.tmux/.tmux.conf ~/.tmux.conf
cp ~/.tmux/.tmux.conf.local ~/.tmux.conf.local

# Install Lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm lazygit lazygit.tar.gz

# Install JetBrains Mono Nerd Font
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip
unzip JetBrainsMono.zip -d ~/.local/share/fonts/
fc-cache -fv
rm JetBrainsMono.zip


#Install Cargo
curl https://sh.rustup.rs -sSf | sh
cargo install bluetui
cargo install impala
cargo install tdf

echo "Installation complete! Please reboot your system to apply all changes."
kill $KEEP_SUDO_PID

## bluetui
