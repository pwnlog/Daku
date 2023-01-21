#!/usr/bin/bash

# Information: 
# - Lab: This script has only been tested on Kali Linux 2022.4 xfce4 with LightDM
# - Author: pwnlog

##################################################################################
#********************************************************************************#
##################################################################################
#                               GLOBALS SECTION                                  #
##################################################################################
#********************************************************************************#
##################################################################################

# Variables
#PS4='${LINENO}: '
CWD=$(pwd)
USER_GROUP=$(id -gn $USER) 
DISTRO=$(uname -r | grep kali)

# ANSI Colors
RED=$(printf '\e[0;91m')
BLUE=$(printf '\e[0;94m')
EXPAND_BG=$(printf '\e[K')
GREEN=$(printf '\e[0;92m')
WHITE=$(printf '\e[0;97m')
BOLD=$(printf '\e[1m')
UNDERLINE=$(printf '\e[4m')
RESET=$(printf '\e[0m')

# Function
function update_failed(){
    cat << EOF
[-] Command: $RED 'sudo apt-get update' $RESET has failed
[-] Solutions: 
    - Please verify that you have an internet connection and also verify if there is a firewall in place
    - Verify if the /etc/apt/sources.list file is configured correctly
EOF
    exit
}

##################################################################################
#********************************************************************************#
##################################################################################
#                             PREREQUISITES SECTION                              #
##################################################################################
#********************************************************************************#
##################################################################################

# Detect if the system is Kali Linux by kernel release
if [[ $DISTRO != *"kali"* ]]; then
    echo "[i] OS: It appears that you're running this script in a system that's NOT Kali Linux"
    echo "[i] WARNING: This script has only been tested in $RED_UNDERLINE_BOLD Kali Linux 2022.4 xfce4 with LightDM $RESET, it may not work for this system"
fi

# Sudo Prompt
echo "[+] Sudo privileges required."
sudo test

# Update the system packages
sudo apt-get update
if [ $? != 0 ]; then
    update_failed
fi

##################################################################################
#********************************************************************************#
##################################################################################
#                            INSTALL SOFTWARE SECTION                            #
##################################################################################
#********************************************************************************#
##################################################################################

# Ensure `deb-scr` is enabled
sudo cp /etc/apt/sources.list /etc/apt/sources.list~
sudo sed -Ei 's/^# deb-src /deb-src /' /etc/apt/sources.list
sudo apt update
if [ $? != 0 ]; then
    update_failed
fi

# Install AwesomeWM
sudo apt build-dep -y awesome
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'sudo apt build-dep awesome' $RESET has failed"
    exit
fi
sudo apt-get install libxcb-xfixes0-dev
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'sudo apt-get install libxcb-xfixes0-dev' $RESET has failed"
    exit
fi
git clone https://github.com/awesomewm/awesome
cd awesome
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'git clone https://github.com/awesomewm/awesome' $RESET has failed"
    exit
fi
# Fix AwesomeWM deb packager owner bug
sudo chown -R _apt ~/Daku/awesome
#sudo chown -R _apt ~/Daku/awesome/build/awesome-*.deb
sudo make package
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'make package' $RESET has failed"
    echo "[i] Trying to fix awesomeWM deb package owner bug"
    sudo chown _apt "~/Daku/awesome/build/awesome-*.deb"
    echo "[i] Trying again to run command: make pakage of awesome"
    sudo make package
    if [ $? != 0 ]; then
        echo "[-] Command: $RED 'make package' $RESET has failed"
        exit
    fi
fi
cd build
sudo apt install -y ./*.deb
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'sudo apt install -y ./*.deb' $RESET has failed"
    exit
fi
cd $CWD

# AwesomeWM LightDM bug fix
sudo bash -c "cat << 'EOF' >> /usr/share/xsessions/awesome.desktop
#!/bin/bash
[Desktop Entry]
Name=awesome
Comment=Highly configurable framework window manager
TryExec=awesome
Exec=awesome
Type=Application
NoDisplay=false
EOF"
if [ $? != 0 ]; then
    echo "[-] Error: Unable to create $RED '/usr/share/xsessions/awesome.desktop' $RESET LightDM bug fix"
    exit
fi

# Install Required Tools
# List:
    # xclip: Copy to clipboard
    # shuf: Generetes random permutations
    # flameshot: Screenshot
    # kitty: Terminal Emulator
    # lxappearance: Change System Theme
    # papirus: System Theme Icons
    # lsd: Replacement for ls
    # bat: Replacement for cat
    # pulseaudio: Audio volume
sudo apt install -y xclip coreutils flameshot kitty lxappearance papirus-icon-theme lsd bat pulseaudio
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'sudo apt install -y xclip coreutils flameshot kitty lxappearance papirus-icon-theme lsd bat pulseaudio' $RESET has failed"
    exit
fi

# Install Optional Tools
sudo apt install -y font-manager
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'sudo apt install -y font-manager' $RESET has failed"
    exit
fi

# Install Theme
for i in bins/themes/Otis*; do sudo tar -xf $i --directory /usr/share/themes; done 
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'for i in bins/themes/Otis*; do sudo tar -xf $i --directory /usr/share/themes; done' $RESET has failed"
    exit
fi

# Install Fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.1/Iosevka.zip -O Iosevka.zip
if [ $? != 0 ]; then
    echo "[-] Failed to download Iosevka font"
    exit
fi
sudo unzip -o Iosevka.zip -d /usr/share/fonts/
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'sudo unzip bins/fonts/Iosevka.zip -d /usr/share/fonts/' $RESET has failed"
    exit
fi

# Install Picom Dependencies
sudo apt install -y libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-dpms0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl-dev libegl-dev libpcre2-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev libpcre3-dev libxcb-sync-dev meson
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'sudo apt install -y libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-dpms0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl-dev libegl-dev libpcre2-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev libpcre3-dev libxcb-sync-dev meson
' $RESET has failed"
    exit
fi

# Install Picom
unzip -o bins/picom/picomv10.2.zip  
cd picom-10.2
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'unzip bins/picom/picomv10.2.zip' $RESET has failed"
    exit
fi
meson setup --buildtype=release . build
ninja -C build 
sudo ninja -C build install
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'sudo ninja -C build install' $RESET has failed"
    exit
fi
cd $CWD

# Install Rofi
sudo apt install -y rofi-dev
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'sudo apt install -y rofi-dev' $RESET has failed"
    exit
fi

# Install Polybar
sudo apt install -y polybar
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'sudo apt install -y polybar' $RESET has failed"
    exit
fi

# Install Feh
sudo apt install -y feh
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'sudo apt install -y feh' $RESET has failed"
    exit
fi

# Install VSCode
sudo dpkg -i bins/vscode/vscode.deb 
sudo apt-get install -f
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'sudo apt-get install -f' $RESET has failed"
    exit
fi

# Install Powerlevel10K
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k 
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k' $RESET has failed"
    exit
fi

# Install xeventbind
git clone https://github.com/ritave/xeventbind.git
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'git clone https://github.com/ritave/xeventbind.git' $RESET has failed"
    exit
fi 
cd xeventbind
make
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'make' $RESET has failed"
    exit
fi                                                                                                                            
sudo cp xeventbind /usr/local/bin 
cd $CWD

# Install i3lock-fancy
sudo apt install -y i3lock
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'sudo apt install -y i3lock' $RESET has failed"
    exit
fi      
git clone https://github.com/meskarune/i3lock-fancy.git
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'git clone https://github.com/meskarune/i3lock-fancy.git' has failed"
    exit
fi     
cd i3lock-fancy
sudo make install
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'sudo make install' $RESET has failed"
    exit
fi  
cd $CWD

# Install nsxiv
sudo apt install -y libimlib2-dev
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'sudo apt install -y libimlib2-dev' $RESET has failed"
    exit
fi  
sudo apt install -y nsxiv
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'sudo apt install -y nsxiv' $RESET has failed"
    exit
fi  

# Install Pen Test Tools
sudo apt install -y bloodhound neo4j powershell
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'sudo apt install -y bloodhound neo4j powershell' $RESET has failed"
    exit
fi

##################################################################################
#********************************************************************************#
##################################################################################
#                         CONFIGURATION FILES SECTION                            #
##################################################################################
#********************************************************************************#
##################################################################################

# Install the configuration files
cp -r $CWD/config/* ~/.config/
sudo cp -r config /root/.config

# Install home configuration files
cp $CWD/home/.fehbg ~/
sudo cp $CWD/home/.fehbg /root
cp $CWD/home/.zshrc ~/
cp $CWD/home/.p10k.zsh ~/
sudo cp $CWD/home/.p10k.zsh /root
sudo cp -r ~/powerlevel10k/ /root

# zshrc symlink with root user
sudo ln -s -f ~/.zshrc /root/.zshrc

# Fix insecure zsh
sudo chown -R root:root /usr/local/share/zsh/site-functions/_bspc &>/dev/null && sudo chmod -R 755 /usr/local/share/zsh/site-functions/_bspc &>/dev/null

# Change default shell
sudo chsh $USER -s $(which zsh) 
sudo chsh root -s $(which zsh) 

# Install the scripts
sudo cp scripts/aesthetics/* /usr/local/bin/
sudo cp scripts/network/* /usr/local/bin/
sudo cp scripts/system/* /usr/local/bin/

##################################################################################
#********************************************************************************#
##################################################################################
#                             PERMISSIONS SECTION                                #
##################################################################################
#********************************************************************************#
##################################################################################

# Polybar permissions
chmod -R 755 ~/.config/polybar 
sudo chmod -R 755 /root/.config/polybar

# Feh permissinons
chmod +x ~/.fehbg
sudo chmod +x /root/.fehbg

# Nsxiv permissions
chmod +x ~/.config/nsxiv/exec/key-handler 

# Scripts permissions

# Aesthetics Scripts
sudo chown $USER:$USER_GROUP /usr/local/bin/wallpaper-changer 
sudo chmod +x /usr/local/bin/wallpaper-changer 

#sudo chown $USER:$USER_GROUP /usr/local/bin/change-corners
#sudo chmod +x /usr/local/bin/change-corners

# System Scripts
sudo chown $USER:$USER_GROUP /usr/local/bin/powermenu
sudo chmod +x /usr/local/bin/powermenu

# Network Scripts
sudo chown $USER:$USER_GROUP /usr/local/bin/ethernet-status
sudo chmod +x /usr/local/bin/ethernet-status

sudo chown $USER:$USER_GROUP /usr/local/bin/vpn-status
sudo chmod +x /usr/local/bin/vpn-status

sudo chown $USER:$USER_GROUP /usr/local/bin/copy-ethernet
sudo chmod +x /usr/local/bin/copy-ethernet

sudo chown $USER:$USER_GROUP /usr/local/bin/copy-vpn
sudo chmod +x /usr/local/bin/copy-vpn

sudo chown $USER:$USER_GROUP /usr/local/bin/target2hack
sudo chmod +x /usr/local/bin/target2hack

sudo chown $USER:$USER_GROUP /usr/local/bin/copy-target
sudo chmod +x /usr/local/bin/copy-target

##################################################################################
#********************************************************************************#
##################################################################################
#                              WALLPAPERS SECTION                                #
##################################################################################
#********************************************************************************#
##################################################################################

# Install wallpapers
mkdir -p ~/Pictures/Wallpapers 
sudo mkdir -p /root/Pictures/Wallpapers 
cp $CWD/wallpapers/daku/* ~/Pictures/Wallpapers 
sudo cp -r $CWD/wallpapers/daku/* /root/Pictures/Wallpapers 

##################################################################################
#********************************************************************************#
##################################################################################
#                              INSTALLATION COMPLETED                            #
##################################################################################
#********************************************************************************#
##################################################################################

# Banner with space
cat << EOF






▓█████▄  ▄▄▄       ██ ▄█▀ █    ██ 
▒██▀ ██▌▒████▄     ██▄█▒  ██  ▓██▒
░██   █▌▒██  ▀█▄  ▓███▄░ ▓██  ▒██░
░▓█▄   ▌░██▄▄▄▄██ ▓██ █▄ ▓▓█  ░██░
░▒████▓  ▓█   ▓██▒▒██▒ █▄▒▒█████▓ 
 ▒▒▓  ▒  ▒▒   ▓▒█░▒ ▒▒ ▓▒░▒▓▒ ▒ ▒ 
 ░ ▒  ▒   ▒   ▒▒ ░░ ░▒ ▒░░░▒░ ░ ░ 
 ░ ░  ░   ░   ▒   ░ ░░ ░  ░░░ ░ ░ 
   ░          ░  ░░  ░      ░     
 ░                                

        Author: pwnlog

EOF

echo "$GREEN [+] Finished installing Daku in your sytem, follow the next steps provided in the$RESET$BLUE README.md$RESET$GREEN file. $RESET"