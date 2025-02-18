#!/bin/bash

# Setup files for testing
mkdir -p ~/.test/bin
# Move network_manager to ~/.test/
echo -e "\033[1;34mMoving networkmanager to ~/.test/\033[0m"
cp -r networkmanager/ ~/.test/
if [ $? -eq 0 ]; then
    echo -e "\033[1;32mSuccess: network_manager moved to ~/.test/\033[0m"
else
    echo -e "\033[1;31mFailure: Could not move network_manager to ~/.test/\033[0m"
fi

# Create directory for rofi wifi in ~/.test/
echo -e "\033[1;34mCreating directory ~/.test/rofi/wifi/\033[0m"
mkdir -p ~/.test/rofi/wifi/
if [ $? -eq 0 ]; then
    echo -e "\033[1;32mSuccess: Directory ~/.test/rofi/wifi/ created\033[0m"
else
    echo -e "\033[1;31mFailure: Could not create directory ~/.test/rofi/wifi/\033[0m"
fi

# Move rofi to ~/.test/rofi/wifi/
echo -e "\033[1;34mMoving rofi to ~/.test/rofi/wifi/\033[0m"
cp -r rofi/ ~/.test/rofi/wifi/
if [ $? -eq 0 ]; then
    echo -e "\033[1;32mSuccess: rofi moved to ~/.test/rofi/wifi/\033[0m"
else
    echo -e "\033[1;31mFailure: Could not move rofi to ~/.test/rofi/wifi/\033[0m"
fi

# Move network_manager to /usr/local/bin/ for testing
echo -e "\033[1;34mMoving network_manager to /usr/local/bin/\033[0m"
sudo cp network_manager ~/.test/bin
if [ $? -eq 0 ]; then
    echo -e "\033[1;32mSuccess: network_manager moved to ~/.test/network_manager\033[0m"
else
    echo -e "\033[1;31mFailure: Could not move network_manager to ~/.test/network_manager\033[0m"
fi
