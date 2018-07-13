#!/bin/bash
echo 'Прписываем имя компьютера'
echo "archlinux" > /etc/hostname
ln -svf /usr/share/zoneinfo/Asia/Yekaterinburg /etc/localtime

echo '3.4 Добавляем русскую локаль системы'
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
echo "ru_RU.UTF-8 UTF-8" >> /etc/locale.gen 

echo 'Обновим текущую локаль системы'
locale-gen

echo 'Указываем язык системы'
echo 'LANG="ru_RU.UTF-8"' > /etc/locale.conf

echo 'Вписываем KEYMAP=ru FONT=cyr-sun16'
echo 'KEYMAP=ru' >> /etc/vconsole.conf
echo 'FONT=cyr-sun16' >> /etc/vconsole.conf

echo 'Создадим загрузочный RAM диск'
mkinitcpio -p linux

echo 'Создаем root пароль'
passwd

echo '3.5 Устанавливаем загрузчик'
pacman -Syy
pacman -S grub --noconfirm 
grub-install /dev/sda

echo 'Обновляем grub.cfg'
grub-mkconfig -o /boot/grub/grub.cfg

echo 'Ставим программу для Wi-fi'
pacman -S dialog wpa_supplicant --noconfirm 

echo 'Добавляем пользователя'
useradd -m -g users -G wheel -s /bin/bash archlinux

echo 'Устанавливаем пароль пользователя'
passwd archlinux
echo 'Устанавливаем SUDO'
echo '%wheel ALL=(ALL) ALL' >> /etc/sudoers

echo 'Раскомментируем репозиторий multilib Для работы 32-битных приложений в 64-битной системе.'
echo '[multilib]' >> /etc/pacman.conf
echo 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf
pacman -Syy

echo "Куда устанавливем Arch Linux на виртуальную машину?"
read -p "1 - Да, 0 - Нет: " vm_setting
if [[ $vm_setting == 0 ]]; then
  gui_install="xorg-server xorg-drivers xorg-xinit"
elif [[ $vm_setting == 1 ]]; then
  gui_install="xorg-server xorg-drivers xorg-xinit virtualbox-guest-utils"
fi

echo 'Ставим иксы и драйвера'
pacman -S $gui_install --noconfirm

echo 'Ставим Xfce, LXDM и сеть'
pacman -S xfce4 xfce4-goodies sddm networkmanager network-manager-applet pulseaudio pavucontrol ppp --noconfirm

echo 'Ставим шрифты'
pacman -S ttf-font-awesome ttf-liberation ttf-dejavu --noconfirm 

echo 'Подключаем автозагрузку менеджера входа и интернет'
systemctl enable sddm.service NetworkManager.service

echo 'Ставим wget'
pacman -S wget --noconfirm 

echo 'Сделайте exit и reboot. После перезагрузки заходим под пользователем'
echo 'После чего скачайте и запустите скрипт, который установит программы, настройки XFCE и темы:'
echo 'wget archlinux.ucoz.net/install3.sh'
echo 'sh install3.sh'
exit
read -p "Пауза 3 ceк." -t 3
reboot