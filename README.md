# dotfiles

This repo contains my dotfiles, nixos configuration and the wallpapers I use.
I manage my dotfiles with [GNU Stow](https://www.gnu.org/software/stow/) or [Home Manger](https://nix-community.github.io/home-manager/).

My dotfiles include configurations for: `alacritty`, `dunst`, `fastfetch`, `fish`, `flameshot`, `hypr`, `nvim`, `oh-my-posh`, `qtile`, `rofi`, `tmux`, `waybar`, `.zshrc`, `.ideavimrc` and `Gruvbox-Material-Dark` icons and themes.

## Installation
```bash
git clone https://github.com/yumo4/dotfiles.git
```
### homemanager
#### installing 
- installing nix (only needed on arch):
```bash
sh <(curl -L https://nixos.org/nix/install) --daemon
```
- using the standalone installation (on the unstable branch):
```bash
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
```
- installing home-manager:
```bash
nix-shell '<home-manager' -A install
```
If you get an error with something like "source not found" or "home-manager not found" log out and log back in and try again.
#### updating your dotfiles
from within the `nixos` directory run
```bash
home-manger switch --flake . --impure
```

### stow
for setting up the symlinks: from within the `dots` directory run
```bash
stow .
```
or for updating / adding a new config run:
```bash
stow . --adopt
```

## nixos

### update config
from within the `nixos` directory (`#device-flake`)
```bash
sudo nixos-rebuild switch --flake .#framework
```

## arch
<setup>
for setting up arch:

### archinstall
packages needed:
```bash
base-devel git stow
```
to install `yay` and `packages` and to setup `tmux tpm` run this script:
```bash
./scripts/setup.sh
```

### pacman config
```bash
sudo vim /etc/pacman.conf
```
add these to the `pacman.conf` file
```bash
# Misc options
Color
ILoveCandy
ParallelDownloads = 5
```
</setup>
