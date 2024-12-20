# Dotfiles

## Requirements
### Git
```bash
pacman -S git
```
### Stow
```bash
pacman -S stow
```
## Installation
Clone the repo
```bash
cd ~/git
```
```bash
git clone https://github.com/yumo4/dotfiles.git
```
```
cd ~/dotfiles 
```

```markdown
dotfiles/
├── dots
│   ├── .config
│   │   ├── alacritty
│   │   ├── fastfetch
│   │   ├── fish
│   │   ├── flameshot
│   │   ├── nvim
│   │   ├── ohmyposh
│   │   ├── qtile
│   │   ├── rofi
│   │   └── tmux
│   ├── .icons
│   │   └── Gruvbox-Material-Dark
│   ├── .ideavimrc
│   ├── .themes
│   │   └── Gruvbox-Material-Dark
│   └── .zshrc
├── scripts
│   └── setup.sh
└── wallpaper
```

Create the symlinks with `stow`
```bash
cd ~/git/dotfiles/dots
```
```bash
stow -t ~ .
```

## Updating
(Delete the files in `~/.config/` / `~/` and) use this for updating
```bash
stow --adopt -t ~ .
```

## archinstall
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
- uncomment `Color` for better readability
- uncomment `ParallelDownloads = 5` for faster downloads
- add `ILoveCandy` for better progressbars


### homemanager
#### installation
#### update config
from within the `nixos` directory
```bash
home-manger switch --flake . --impure
```

### stow
from within the `dots` directory
```bash
stow .
```
or for updating / adding a new config
```bash
stow . --adopt
```

## nixos

### update config
from within the `nixos` directory (`#device flake`)
```bash
sudo nixos-rebuild switch --flake .#framework
```

## arch

<details>
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
```bash
# Misc options
Color
ILoveCandy
ParallelDownloads = 5
```
</details>
