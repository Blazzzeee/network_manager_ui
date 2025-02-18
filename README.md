## About the project
A better way to do wifi menu

The project is primarily aimed for people are newbs to linux distros and want a generic solution for whatever they window manager , or desktop environment they hope on, worrying about ui for wifi menu is annoying , also gtk, qt implementation look wierd to me for some reason if you are in this category this might work for you, other options lack either proper pre configured ui or have a shady look or are non functional in their performance charts . This tries to act as your prefferred way to do wifi menu . The project remains open to any healthy criticism and ideas

If you are looking for a plug and play utility to manage wifi and ethernet connections , network_manager_ui might be the choice for you

This project uses rofi as a ui library and python script as backend to create a seamless, beautiful, elegant and working network manager 

If you dont like system tray implementations such as nm_appllet , try this project ! 

Other implementations such network_manager_rofi is very slow and somewhat inefficent 

Also since the project uses rofi , using Search functionality saves you the time of scrolling when you already know what you want to do!

## Demonstration



## Theming 
The menu comes in four diffrent flavours or themes which are references to great color palletes

1.Catppuccin Mocha <br>
  ![catppuccin](assets/u-cat.jpg)
<br><br><br>
2. Nord - Arctic vibes
<br>
  ![](assets/ui-nord.jpg)
<br><br><br>
3. Rospine - Sooho Vibes
<br>
  ![](assets/ui-rose.jpg)
<br><br><br>
4. Monochrome - Minimalism
   <br>
   ![](assets/ui-tra.jpg)
<br><br><br>

To change themes go to ~/.config/rofi/wifi/config.rasi and change theme name to whatever you like 

## Installation

Installation Guide-
Dependencies- rofi, or rofi-wayland if you are on wayland , NetworkManager , Python3 , pinentry-gtk(default) or pinentry-qt
Some form of notification system (ex if you are on a wlroots based compositor swayvnc) 

### For Arch linux
If you are on arch-based system 

```bash
sudo pacman -Syy rofi-wayland networkmanager python3 pinentry swaync --needed
```
### For Ubuntu/Debian
```bash
sudo apt update && sudo apt install rofi network-manager python3 pinentry swaync
```

### For Fedora
```bash
sudo dnf install rofi networkmanager python3 pinentry swaync
```
### Install
```bash
git clone https://github.com/Blazzzeee/network_manager_ui.git
cd network_manager_ui
./install.sh
```
### Usage
Run the menu by calling network_manager as a keybind or from your panel such as waybar , polybar etc , without any system tray
, don't forget to restart terminal after installation :D
```bash
network_manager
```
