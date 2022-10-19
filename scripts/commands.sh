#!/bin/sh
# Msic commands 

# set zsh as the default shell requies session to be restarted
    chsh -s $(which zsh)

# gnome shell application and workspace switch
    gsettings list-recursively | grep switch-to-application | sort
    gsettings list-recursively | grep switch-to-workspace | sort


# generate-ssh-key.sh 
    ssh-keygen -t rsa -b 4096 -N '' -C "shrestharajat@hotmail.com" -f ~/.ssh/id_rsa
    ssh-keygen -t rsa -b 4096 -N '' -C "shrestharajat@hotmail.com" -f ~/.ssh/github_rsa
    ssh-keygen -t rsa -b 4096 -N '' -C "shrestharajat@hotmail.com" -f ~/.ssh/mozilla_rsa

# ssh-key-add.sh 
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_rsa
    ssh-add ~/.ssh/github_rsa
    ssh-add ~/.ssh/mozilla_rsa


# Fix .ssh folder permissions
    chown $USER:$USER /home/$USER/.ssh
    chown $USER:$USER /home/$USER/.ssh/authorized_keys
    chmod 700 /home/$USER/.ssh
    chmod 644 /home/$USER/.ssh/authorized_keys
    chmod 644 /home/$USER/.ssh/known_hosts
    chmod 600 /home/$USER/.ssh/id_rsa
    chmod 644 /home/$USER/.ssh/id_rsa.pub
