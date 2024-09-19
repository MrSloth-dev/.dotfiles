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
sudo apt install -y curl wget cmake git zsh neovim python3 i3 i3-wm rofi tmux neofetch gimp btop \
    virtualbox picom redshift unrar unzip xwallpaper \
    build-essential libssl-dev libcurl4-openssl-dev libxml2-dev libxcb-xinerama0-dev \
    libxcb-icccm4-dev libxcb-randr0-dev libxcb-util0-dev libxcb-xrm-dev libxcb-xkb-dev \
    pkg-config xcb libxcb-image0-dev libjsoncpp-dev libmpdclient-dev libcurl4-openssl-dev \
    libnl-genl-3-dev polybar

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install Wezterm
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
sudo apt update
sudo apt install -y wezterm

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

echo "Installation complete! Please reboot your system to apply all changes."
kill $KEEP_SUDO_PID
