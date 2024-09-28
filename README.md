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
├── rofiscripts
│    ├── screenSettings.sh
│    ├── defaultResolution.sh
│    ├── mirrorScreen.sh
│    └── screenshot.sh
└── scripts
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
sudo vim /etv/pacman.conf
```
- uncomment `Color` for better readability
- uncomment `ParallelDownloads = 5` for faster downloads
- add `ILoveCandy` for better progressbars
