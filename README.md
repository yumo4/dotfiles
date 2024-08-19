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
│   │   ├── fish
│   │   ├── flameshot
│   │   ├── nvim
│   │   ├── nvim_own_broken
│   │   ├── ohmyposh
│   │   ├── rofi
│   │   └── tmux
│   ├── .icons
│   │   └── Gruvbox-Material-Dark
│   ├── .ideavimrc
│   ├── .themes
│   │   └── Gruvbox-Material-Dark
│   └── .zshrc
├── rofiscripts
│   └── screenSettings.sh
└── scripts
    ├── defaultResolution.sh
    ├── mirrorScreen.sh
    └── screenshot.sh
```

Create the symlinks with `stow`
```bash
cd ~/git/dotfiles/dots
```
```bash
stow -t ~ .
```

## Updating
Delete the files in `~/.config/` / `~/` and use this for updating
```bash
stow --adopt -t ~ .
```
