#!/bin/bash
echo 'Установка AUR (aurman)'
sudo pacman -Syy
sudo pacman -S git --noconfirm

# Обновляем систему
sudo pacman -Syu

# Создаём aurman_install директорию и переходим в неё
mkdir -p /tmp/aurman_install
cd /tmp/aurman_install

# Установка "aurman" из AUR
git clone https://aur.archlinux.org/aurman-git.git
cd aurman-git
makepkg -si --needed --noconfirm --skippgpcheck
rm -rf aurman_install

echo 'Установка программ'
sudo pacman -S firefox ufw obs-studio veracrypt freemind filezilla engrampa cherrytree gimp libreoffice libreoffice-fresh-ru kdenlive audacity pidgin screenfetch vlc qt4 qbittorrent f2fs-tools dosfstools ntfs-3g alsa-lib alsa-utils gnome-calculator file-roller p7zip unrar gvfs aspell-ru pulseaudio --noconfirm 
aurman -S dropbox joxi obs-linuxbrowser xflux xflux-gui-git purple-vk-plugin purple-facebook pidgin-encryption sublime-text2 hunspell-ru pamac-aur --noconfirm 

echo 'Установка тем'
aurman -S osx-arc-shadow xcursor-breeze-serie-obsidian papirus-maia-icon-theme-git --noconfirm


echo 'Ставим лого ArchLinux в меню'
wget ordanax.ru/arch/archlinux_logo.png
sudo mv -f ~/Downloads/archlinux_logo.png /usr/share/pixmaps/archlinux_logo.png

echo 'Ставим обои на рабочий стол'
wget ordanax.ru/arch/Deepin_Linux_Manjaro.jpg
sudo mv -f ~/Downloads/Deepin_Linux_Manjaro.jpg ~/Dropbox/WALLPAPERS/GREEN/Deepin_Linux_Manjaro.jpg
rm -rf ~/Downloads/*

echo 'Включаем сетевой экран'
sudo ufw enable

echo 'Установка завершена!'
rm -rf ~/install3.sh