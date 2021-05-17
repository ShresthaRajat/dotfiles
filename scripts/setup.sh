#!/bin/bash

# Install prorams
  declare -a programs=( \
    "vim" "python3" "python3-pip" "zsh" "code" "git" "curl" "tree" \
    "neofetch" "lolcat" "lm-sensors" "tlp" "gnome-tweaks" "deluge" \
    "bleachbit" "cmake" "vlc" "wmctrl" "python3-setuptools" "xdotool" \
    "python3-gi" "libinput-tools" "python-gobject" "figlet"\
    "apt-transport-https" "ca-certificates" "gnupg-agent" \
    "software-properties-common" \
  )
  for p in "${programs[@]}"
  do
    echo "$p"
    sudo apt install -y $p
  done

# Fix workspace switching
  figlet RECONFIGURE KEY-BINDINGS
  gsettings list-recursively | grep switch-to-application | sort
  gsettings list-recursively | grep switch-to-workspace | sort

  declare -a nums=(1 .. 9)
  for i in $(seq 9  $END);
  do
    echo $i;
    gsettings set org.gnome.shell.keybindings switch-to-application-$i "[]"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-$i "['<Super><Shift>$i']"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-$i "['<Super>$i', '<Ctrl>$i']"
  done
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "['<Super>1', '<Ctrl>1', '<Super>Home']"
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 "['<Super>4', '<Ctrl>4', '<Super>End']"
  gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-1 "['<Super><Shift>1', '<Super><Shift>Home']"
  gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-4 "['<Super><Shift>4', '<Super><Shift>End']"

# Clone files for zsh and gestures
  sudo git clone https://github.com/zdharma/fast-syntax-highlighting.git /usr/share/zsh/plugins/fast-syntax-highlighting
  sudo git clone https://github.com/zsh-users/zsh-autosuggestions.git /usr/share/zsh/plugins/zsh-autosuggestions
  sudo git clone https://github.com/bulletmark/libinput-gestures.git ~/.config/libinput_gestures
  sudo git clone https://gitlab.com/cunidev/gestures.git ~/.config/gestures

# Install TLP
  sudo add-apt-repository ppa:linrunner/tlp
  
  sudo apt -y update
  sudo apt -y install tlp tlp-rdw
  sudo apt -y install acpi-call-dkms
  sudo tlp start 
  sudo systemctl status tlp

# Install Docker
  sudo apt remove docker docker-engine docker.io containerd runc
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo apt-key fingerprint 0EBFCD88
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
  sudo apt update
  sudo apt -y upgrade
  sudo apt -y install docker-ce docker-ce-cli containerd.io
  sudo groupadd docker
  sudo usermod -aG docker $USER
  sudo docker run hello-world

# Install Gestures
  sudo gpasswd -a $USER input
  cd ~/.config/libinput_gestures
  sudo make install
  libinput-gestures-setup autostart
  libinput-gestures-setup start
  cd ~/.config/gestures
  meson build --prefix=/usr
  ninja -C build
  sudo ninja -C build install

# Miscellanious stuffs
  # fix time for dualboot with windows 10
  timedatectl set-local-rtc 1 --adjust-system-clock
  # change zsh configs location
  sudo echo "export ZDOTDIR='${XDG_CONFIG_HOME:-/home/$USER/.config}/zsh'" | sudo tee -a /etc/zsh/zshenv
  # change default shell to zsh
  chsh -s "$(which zsh)"
  # Install docker compose:
  sudo curl -L "https://github.com/docker/compose/releases/download/1.26.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose