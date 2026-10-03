#!/bin/bash

set -e
# Download github
wget -O main.zip https://github.com/Ni-ck-W/wmSetup/archive/refs/heads/main.zip
sudo pacman -Syu --noconfirm \
    unzip
unzip main.zip
rm main.zip

#moving most config files
mkdir -p ~/.config
mv wmSetup-main/* ~/.config/ 2>/dev/null || true
mv wmSetup-main/.[!.]* ~/.config/ 2>/dev/null || true

#bash_profile
rm -f ~/.bash_profile
mv ~/.config/.bash_profile ~/

#background
mkdir -p ~/Pictures
mv ~/.config/ben_10_red.jpg ~/Pictures/ 2>/dev/null || true

#cleanup
rm -f ~/.config/README.md
rm -rf wmSetup-main

#base system app installs
sudo pacman -Syu --noconfirm \
    sway qt6ct swaybg swaync hyprland breeze breeze-gtk conky clapper imv flameshot localsend polkit-gnome waybar rofi network-manager-applet blueman brightnessctl otf-font-awesome ttf-font-nerd dolphin ly foot ufw

#custom app files
mkdir -p ~/.local/share/applications
mv ~/.config/screenshot.desktop ~/.local/share/applications 2>/dev/null || true
mv ~/.config/files.desktop ~/.local/share/applications 2>/dev/null || true
update-desktop-database ~/.local/share/applications || true

#localsend firewall
sudo ufw allow 53317/tcp
sudo ufw allow 53317/udp

#Ly setup
sudo systemctl disable getty@tty1.service
sudo systemctl enable ly@tty1.service

#change shell
chsh -s /bin/bash

reboot
