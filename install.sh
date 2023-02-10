#!/usr/bin/bash

# Information: 
# - Lab: This script has only been tested on Kali Linux 2022.4 and ParrotOS 5.2 Security Edition
# - Author: pwnlog

# Compatible Systems:
# - Kali Linux
# - ParrotOS

# Some software are installed from releases instead of APT for the following reasons:
# 1. Stability
# 2. Configuration Bugs
# 3. Works in multiple systems

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
#if [[ $DISTRO != *"kali"* ]]; then
#    echo "[i] OS: It appears that you're running this script in a system that's NOT Kali Linux"
#    echo "[i] WARNING: This script has only been tested in $RED_UNDERLINE_BOLD Kali Linux 2022.4 xfce4 with LightDM $RESET, it may not work for this system"
#fi

# Sudo Prompt
echo "[+] Sudo privileges required."
sudo test

# Update the system packages
sudo apt-get update
if [ $? != 0 ]; then
    update_failed
fi

# Aptitude Support for solving dependencies, downgrading, upgrading, and making sure packages work
sudo apt install -y aptitude
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'sudo apt install -y aptitude' $RESET has failed"
    exit
fi

# VMware Support (GUI)
sudo apt install -y open-vm-tools-desktop
if [ $? != 0 ]; then
    echo "[-] Failed to install VMware tools"
fi
# Enable Copy-Paste between Guest and VM with: /usr/bin/vmware-user-suid-wrapper

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

# Install AwesomeWM dependencies for some system such as ParrotOS
sudo apt-get install -y imagemagick libcairo2-dev

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
sudo apt install -y thunar xclip coreutils flameshot kitty lxappearance papirus-icon-theme bat pulseaudio redshift bluez pulseaudio-utils playerctl maim dunst light exa gir1.2-playerctl-2.0 network-manager 
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'sudo apt install -y xclip coreutils flameshot kitty lxappearance papirus-icon-theme lsd bat pulseaudio playerctl maim dunst light exa gir1.2-playerctl-2.0' $RESET has failed"
    exit
fi

# ParrotOS
wget https://github.com/Peltoche/lsd/releases/download/0.23.0/lsd_0.23.0_amd64.deb -O lsd_0.23.0_amd64.deb
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'wget https://github.com/Peltoche/lsd/releases/download/0.23.0/lsd_0.23.0_amd64.deb -O lsd_0.23.0_amd64.deb' $RESET has failed"
    exit
fi
sudo dpkg -i lsd_0.23.0_amd64.deb 

sudo apt install -y build-essential libxft-dev libharfbuzz-dev
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'sudo apt install -y build-essential libxft-dev libharfbuzz-dev' $RESET has failed"
    exit
fi

# Install BSPWM
sudo apt-get install -y libxcb-xinerama0-dev libxcb-icccm4-dev libxcb-randr0-dev libxcb-util0-dev libxcb-ewmh-dev libxcb-keysyms1-dev libxcb-shape0-dev
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'sudo apt-get install -y libxcb-xinerama0-dev libxcb-icccm4-dev libxcb-randr0-dev libxcb-util0-dev libxcb-ewmh-dev libxcb-keysyms1-dev libxcb-shape0-dev' $RESET has failed"
    exit
fi
git clone https://github.com/baskerville/bspwm.git
git clone https://github.com/baskerville/sxhkd.git
cd bspwm && make && sudo make install
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'cd bspwm && make && sudo make install' $RESET has failed"
    exit
fi
cd ../sxhkd && make && sudo make install
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'cd ../sxhkd && make && sudo make install' $RESET has failed"
    exit
fi
cd $CWD

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
    echo "[-] Command: $RED 'sudo unzip -o Iosevka.zip -d /usr/share/fonts/' $RESET has failed"
    exit
fi

# Install Picom Dependencies
sudo apt install -y libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-dpms0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl-dev libegl-dev libpcre2-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev libpcre3-dev libxcb-sync-dev meson
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'sudo apt install -y libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-dpms0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl-dev libegl-dev libpcre2-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev libpcre3-dev libxcb-sync-dev meson
' $RESET has failed"
    exit
fi

# Install Picom (fix black border)
wget "https://github.com/yshui/picom/archive/refs/tags/v9.1.zip" -O picomv9.1.zip
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'wget \"https://github.com/yshui/picom/archive/refs/tags/v9.1.zip\" -O picomv9.1.zip' $RESET has failed"
    exit
fi
unzip -o picomv9.1.zip 
cd picom-9.1
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'unzip -o picomv9.1.zip' $RESET has failed"
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

# Install Rofi from releases (Why? Because different systems have different versions in their APT)
sudo apt install -y bison flex check
# Remove old version (if installed)
sudo apt purge rofi 2>/dev/null
wget https://github.com/davatorium/rofi/releases/download/1.7.5/rofi-1.7.5.tar.gz -O rofi-1.7.5.tar.gz
if [ -f "rofi-1.7.5.tar.gz" ]; then
    echo "[+] The file rofi-1.7.5.tar.gz was downloaded."
else 
    echo "[-] The file rofi-1.7.5.tar.gz was not downloaded."
    exit
fi
tar -xvf rofi-1.7.5.tar.gz
cd rofi-1.7.5
mkdir build 
cd build 
../configure 
make 
sudo make install 
if [ $? != 0 ]; then
    echo -e "[-] Failed to install rofi!"
    exit
fi
cd $CWD

# Install Polybar from releases 
#sudo aptitude install python3-sphinx
sudo pip install sphinx
sudo apt install -y build-essential git cmake cmake-data pkg-config python3-packaging libuv1-dev libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev
# Remove old version (if installed)
sudo apt purge polybar
wget https://github.com/polybar/polybar/releases/download/3.6.3/polybar-3.6.3.tar.gz -O polybar-3.6.3.tar.gz
echo "f25758573567208fc7b6f4d4115a6117a87389cbcc094cf605d079775be95fa5 polybar-3.6.3.tar.gz" | sha256sum -c
if [ $? != 0 ]; then
    echo -e "[-] Failed to download polybar-3.6.3.tar.gz correctly!"
    exit
fi
tar -xvf polybar-3.6.3.tar.gz
cd polybar-3.6.3
mkdir build
cd build
cmake ..
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'cmake ..' $RESET has failed"
    exit
fi
make -j$(nproc)
sudo make install
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'sudo make install $RESET has failed"
    exit
fi
cd $CWD

# Install Rofi
#sudo apt install -y rofi-dev
#if [ $? != 0 ]; then
#    echo "[-] Command: $RED 'sudo apt install -y rofi-dev' $RESET has failed"
#    exit
#fi

# Install Polybar
#sudo apt install -y polybar
#if [ $? != 0 ]; then
#    echo "[-] Command: $RED 'sudo apt install -y polybar' $RESET has failed"
#    exit
#fi

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

# Install neovim
sudo apt install -y neovim 
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'sudo apt install -y neovim' $RESET has failed"
    exit
fi

# Install LSP neovim related stuff
sudo apt install -y python3-venv cargo npm
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'sudo apt install -y python3-venv' $RESET has failed"
    exit
fi
#nvim --headless +PlugInstall +qa
#MasonInstall python-lsp-server
#MasonInstall asm-lsp
#MasonInstall bash-language-server

# Install Powerlevel10K
rm -rf ~/powerlevel10k 2>/dev/null
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k 
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k' $RESET has failed"
    exit
fi

# Install xeventbind
rm -rf xeventbind 2>/dev/null
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
rm -rf i3lock-fancy 2>/dev/null     
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
    echo -e "\n\n\n"
    echo "$BLUE [!] User interaction required, please read the TROUBLESHOOTING.md file for more information $RESET"
    echo -e "\n\n\n"
    sudo aptitude install libdeflate0
    sudo aptitude install libdeflate-dev
    sudo aptitude install libimlib2-dev
    #exit
fi  
sudo apt-get install -y libexif-dev
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'sudo apt-get install -y libexif-dev' $RESET has failed"
    exit
fi  
git clone https://github.com/nsxiv/nsxiv
cd nsxiv
sudo make install-all
cd $CWD

#sudo apt install -y nsxiv
#if [ $? != 0 ]; then
#    echo "[-] Command: $RED 'sudo apt install -y nsxiv' $RESET has failed"
#    exit
#fi  

# Install mpd and mpc
sudo apt install -y mpd mpc
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'sudo apt install -y mpd mpc' $RESET has failed"
    exit
fi
systemctl --user enable mpd.service
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'systemctl --user enable mpd' $RESET has failed"
    exit
fi

# Install ncmpcpp
sudo apt install -y ncmpcpp
if [ $? != 0 ]; then
    echo "[-] Command: $RED 'systemctl --user enable mpd.service' $RESET has failed"
    exit
fi  

# Install pywal
sudo pip3 install pywal 
if [ $? != 0 ]; then
    echo "[-] Command: $RED sudo pip3 install pywal $RESET has failed"
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

sudo chown $USER:$USER_GROUP /usr/local/bin/wallpaper-scheduler 
sudo chmod +x /usr/local/bin/wallpaper-scheduler 

sudo chown $USER:$USER_GROUP /usr/local/bin/default-wallpaper
sudo chmod +x /usr/local/bin/default-wallpaper

sudo chown $USER:$USER_GROUP /usr/local/bin/default-polybar
sudo chmod +x /usr/local/bin/default-polybar

sudo chown $USER:$USER_GROUP /usr/local/bin/change-corners
sudo chmod +x /usr/local/bin/change-corners

sudo chown $USER:$USER_GROUP /usr/local/bin/pywal
sudo chmod +x /usr/local/bin/pywal

sudo chown $USER:$USER_GROUP /usr/local/bin/restore-daku
sudo chmod +x /usr/local/bin/restore-daku

# System Scripts
sudo chown $USER:$USER_GROUP /usr/local/bin/powermenu
sudo chmod +x /usr/local/bin/powermenu

sudo chown $USER:$USER_GROUP /usr/local/bin/install-tools
sudo chmod +x /usr/local/bin/install-tools

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

# Fix wallpaper for other usernames
sed -ie "s/kali/$USER/g" ~/.fehbg
sudo sed -ie "s/kali/root/g" /root/.fehbg

# Fix thunar
sed -ie "s/kali/$USER/g" ~/.config/gtk-3.0/bookmarks
sudo sed -ie "s/kali/root/g" /root/.config/gtk-3.0/bookmarks

# Fix qterminal
sed -ie "s/kali/$USER/g" ~/.config/qterminal.org/qterminal.ini 
sudo sed -ie "s/kali/root/g" /root/.config/qterminal.org/qterminal.ini 

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

echo "$GREEN [+] Finished installing Daku in your system, follow the next steps provided in the$RESET$BLUE README.md$RESET$GREEN file. $RESET"