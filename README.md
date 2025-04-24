# dotfiles

This repo contains my dotfiles, nixos configuration and the wallpapers I use.
I manage my dotfiles with [Home Manger](https://nix-community.github.io/home-manager/).

My dotfiles include configurations for: `alacritty`, `fastfetch`, `fish`, `flameshot`, `ghostty`, `hyprland`, `nvim`, `oh-my-posh`, `qtile`, `rofi`, `tmux`, `waybar`, `.zshrc`, `.ideavimrc` and `Gruvbox-Material-Dark` icons and themes.

## Installation
```bash
nix-shell -p git neovim ghostty
```
```bash
git clone git@github.com:yumo4/dotfiles.git
```
- create new host directory
- copy hardware configuration into host directory
```bash
sudo cp /etc/nixos/hardware-configuration.nix .
```
inside of the `nixos` directory run this to build your system
```bah
sudo nixos-rebuild switch --flake .#<hostname> --show-trace
```
### homemanager
#### installing 
- using the standalone installation (on the unstable branch):
```bash
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
```
- installing home-manager:
```bash
nix-shell '<home-manager>' -A install
```
If you get an error with something like "source not found" or "home-manager not found" log out and log back in and try again.
#### updating your dotfiles
from within the `nixos` directory run
on nixos:
```bash
home-manager switch --flake . --impure
```

<details>

<summary>arch & stow stuff</summary>

## stow

for setting up the symlinks: from within the `dots` directory run
```bash
stow .
```
or for updating / adding a new config run:
```bash
stow . --adopt

## arch

### archinstall

packages needed:
```bash
base-devel git stow
```
to install `yay` and `packages` and to setup `tmux tpm` run this script:
```bash
./scripts/setup.sh
```

### nix install

- installing nix (only needed on arch):
```bash
sh <(curl -L https://nixos.org/nix/install) --daemon
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

### updating using home-manager 
```bash
home-manger switch --flake . --impure --extra-experimental-features nix-command --extra-experimental-features flakes
```
</details>
