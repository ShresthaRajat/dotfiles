#!/bin/bash

# Installs programs fixes the workspace keyboard shortcuts

# Install prorams
  declare -a programs=( \
    "lm-sensors" "vim" "zsh" "code" "git" "curl" \
    "software-properties-common" \
  )
  for p in "${programs[@]}"
  do
    echo "$p"
    sudo apt install -y $p
  done

# Fix workspace switching
#  gsettings list-recursively | grep switch-to-application | sort
#  gsettings list-recursively | grep switch-to-workspace | sort

  declare -a nums=(1 .. 4)
  for i in $(seq 9  $END);
  do
    echo $i;
    gsettings set org.gnome.shell.keybindings switch-to-application-$i "[]"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-$i "['<Super><Shift>$i']"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-$i "['<Super>$i']"
  done
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "['<Super>1', '<Super>Home']"
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 "['<Super>4', '<Super>End']"
  gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-1 "['<Super><Shift>1', '<Super><Shift>Home']"
  gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-4 "['<Super><Shift>4', '<Super><Shift>End']"

# Clone files for zsh 
  sudo git clone https://github.com/zdharma/fast-syntax-highlighting.git /usr/share/zsh/plugins/fast-syntax-highlighting
  sudo git clone https://github.com/zsh-users/zsh-autosuggestions.git /usr/share/zsh/plugins/zsh-autosuggestions

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
