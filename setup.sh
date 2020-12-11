#!/bin/sh

#####################################################################################################################
#  ___ _   _ ____ _____  _    _     _
# |_ _| \ | / ___|_   _|/ \  | |   | |
#  | ||  \| \___ \ | | / _ \ | |   | |    
#  | || |\  |___) || |/ ___ \| |___| |___ 
# |___|_| \_|____/ |_/_/   \_\_____|_____|
#                                        
#  _____ ____ ____  _____ _   _ _____ ___    _    _     ____  
# | ____/ ___/ ___|| ____| \ | |_   _|_ _|  / \  | |   / ___| 
# |  _| \___ \___ \|  _| |  \| | | |  | |  / _ \ | |   \___ \ 
# | |___ ___) |__) | |___| |\  | | |  | | / ___ \| |___ ___) |
# |_____|____/____/|_____|_| \_| |_| |___/_/   \_\_____|____/ 
#####################################################################################################################
sudo apt -y install figlet
figlet INSTALL ESSENTIALS
declare -a programs=("vim" "python3" "python3-pip" "zsh" "code" "git" "curl" "tree" "neofetch" "lolcat" "lm-sensors" "tlp" "gnome-tweaks" "deluge" "bleachbit" "cmake" "vlc" "wmctrl" "python3-setuptools" "xdotool" "python3-gi" "libinput-tools" "python-gobject")

for p in "${programs[@]}"
do
   echo "$p"
   sudo apt -y install $p
done
sudo git clone https://github.com/zdharma/fast-syntax-highlighting.git /usr/share/zsh/plugins/fast-syntax-highlighting
sudo git clone https://github.com/zsh-users/zsh-autosuggestions.git /usr/share/zsh/plugins/zsh-autosuggestions
# move ~/.zshrc to ~/.config/zsh/.zshrc

#Disable default application <super>[Num] bindings and set to workspace switching
#####################################################################################################################
#  ____  _____ ____ ___  _   _ _____ ___ ____ _   _ ____  _____ 
# |  _ \| ____/ ___/ _ \| \ | |  ___|_ _/ ___| | | |  _ \| ____|
# | |_) |  _|| |  | | | |  \| | |_   | | |  _| | | | |_) |  _|  
# |  _ <| |__| |__| |_| | |\  |  _|  | | |_| | |_| |  _ <| |___ 
# |_| \_\_____\____\___/|_| \_|_|   |___\____|\___/|_| \_\_____|
                                                              
#  _  _________   __    ____ ___ _   _ ____ ___ _   _  ____ ____  
# | |/ / ____\ \ / /   | __ )_ _| \ | |  _ \_ _| \ | |/ ___/ ___| 
# | ' /|  _|  \ V /____|  _ \| ||  \| | | | | ||  \| | |  _\___ \ 
# | . \| |___  | |_____| |_) | || |\  | |_| | || |\  | |_| |___) |
# |_|\_\_____| |_|     |____/___|_| \_|____/___|_| \_|\____|____/ 
#####################################################################################################################
figlet RECONFIGURE KEY-BINDINGS
gsettings list-recursively | grep switch-to-application | sort
gsettings list-recursively | grep switch-to-workspace | sort

declare -a nums=(1 .. 9)

for i in $(seq 9  $END);
do
  echo $i;
  gsettings set org.gnome.shell.keybindings switch-to-application-$i "[]"
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-$i "['<Super>$i', '<Ctrl>$i']"
done
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "['<Super>1', '<Ctrl>1', '<Super>Home']"

#move apps like in i3
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-1 "['<Super><Shift>1', '<Super><Shift>Home']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-2 "['<Super><Shift>2']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-3 "['<Super><Shift>3']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-4 "['<Super><Shift>4', '<Super><Shift>End']"

gsettings list-recursively | grep switch-to-application | sort
gsettings list-recursively | grep switch-to-workspace | sort

# workspace switching



# For libinput gestures and gestures app from gitlab
sudo apt install wmctrl python3 python3-setuptools xdotool python3-gi libinput-tools python-gobject
clear
figlet "SETUP ENDED!" 


# cp ./dotfiles/.bash_aliases .bash_aliases
# echo "alias lsR='ls -R'" >> ~/.bash_aliases 


echo "Please change the hardcoded username at the end of this file"
###
### The name is hardcoded here------------------| Change it according to your setting
###                                             |
echo "export ZDOTDIR='${XDG_CONFIG_HOME:-/home/rajat/.config}/zsh'" | sudo tee -a /etc/zsh/zshenv


figlet "cloning files for gestures"
apt install -y wmctrl python3 python3-setuptools xdotool python3-gi libinp
ut-tools python-gobject
git clone https://github.com/bulletmark/libinput-gestures.git ~/.config/libinput
_gestures
git clone https://gitlab.com/cunidev/gestures.git ~/.config/gestures

