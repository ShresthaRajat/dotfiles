# Rajat's config for PopOS

## Installation

clone this into .config, run the setup and do the post installation rituals

```bash
bash setup.sh
```

## Post Installation

After installing all of the stuff and restarting run the following commands:

``` bash
newgrp docker
chsh -s $(which zsh)
```


## Post Installation Tests
- [ ] Check if zsh is configured
- [ ] Check if TLP is configured
- [ ] Check if Docker is Installed
- [ ] Check gestures
- [ ] Check Workspace keybindings


## Detailed Post Instaalation guide:

Uncomment these lines on `/etc/tlp.conf`:

```bash
START_CHARGE_THRESH_BAT0=75
STOP_CHARGE_THRESH_BAT0=80
START_CHARGE_THRESH_BAT1=75
STOP_CHARGE_THRESH_BAT1=80
```