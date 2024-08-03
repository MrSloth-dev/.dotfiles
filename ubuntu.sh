#!/bin/bash

if [ "$EUID" -eq 0 ]; then 
  echo "Please run this script as a normal user, not as root."
  exit
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

# Update package lists
sudo apt update

# Install list of packages
sudo apt install -y git zsh neovim python3 i3 rofi tmux neofetch gimp btop libreoffice-suite-gnome virtualbox picom redshift unrarunzip wget xwallpaper

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Polybar
sudo apt install -y cmake pkg-config libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev
git clone https://github.com/polybar/polybar.git
cd polybar
mkdir build
cd build
cmake ..
make -j$(nproc)
sudo make install
cd ../..

# Install Wezterm
curl -LO https://github.com/wez/wezterm/releases/download/nightly/wezterm-nightly.Ubuntu20.04.deb
sudo apt install -y ./wezterm-nightly.Ubuntu20.04.deb
rm wezterm-nightly.Ubuntu20.04.deb

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

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip
unzip JetBrainsMono.zip -d ~/.local/share/fonts/
fc-cache -fv
rm JetBrainsMono.zip

# Set up wallpaper (you'll need to provide the path to your wallpaper)
# mkdir -p ~/Pictures/Wallpapers
# cp /path/to/your/wallpaper.jpg ~/Pictures/Wallpapers/
# gsettings set org.gnome.desktop.background picture-uri file:///home/$USER/Pictures/Wallpapers/wallpaper.jpg

echo "Installation complete! Please reboot your system to apply all changes."
kill $KEEP_SUDO_PID
