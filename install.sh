#!/bin/bash


# Move network_manager to ~/.config/
echo -e "\033[1;34mMoving networkmanager to ~/.config/\033[0m"
cp -r networkmanager/ ~/.config/
if [ $? -eq 0 ]; then
    echo -e "\033[1;32mSuccess: network_manager moved to ~/.config/\033[0m"
else
    echo -e "\033[1;31mFailure: Could not move network_manager to ~/.config/\033[0m"
fi

# Create directory for rofi wifi
echo -e "\033[1;34mCreating directory ~/.config/rofi/wifi/\033[0m"
mkdir -p ~/.config/rofi/wifi/
if [ $? -eq 0 ]; then
    echo -e "\033[1;32mSuccess: Directory ~/.config/rofi/wifi/ created\033[0m"
else
    echo -e "\033[1;31mFailure: Could not create directory ~/.config/rofi/wifi/\033[0m"
fi

# Move rofi to ~/.config/rofi/wifi/
echo -e "\033[1;34mMoving rofi to ~/.config/rofi/wifi/\033[0m"
cp -r rofi/ ~/.config/rofi/wifi/
if [ $? -eq 0 ]; then
    echo -e "\033[1;32mSuccess: rofi moved to ~/.config/rofi/wifi/\033[0m"
else
    echo -e "\033[1;31mFailure: Could not move rofi to ~/.config/rofi/wifi/\033[0m"
fi

# Move network_manager script to /usr/local/bin/
echo -e "\033[1;34mMoving network_manager to /usr/local/bin/\033[0m"
sudo cp network_manager /usr/local/bin/
if [ $? -eq 0 ]; then
    echo -e "\033[1;32mSuccess: network_manager moved to /usr/local/bin/\033[0m"
else
    echo -e "\033[1;31mFailure: Could not move network_manager to /usr/local/bin/\033[0m"
fi

