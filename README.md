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
Create the symlinks with ```stow```
```bash
cd ~/git/dotfiles/common
```
```bash
stow -t ~ .
```
### Desktop
Create the symlinks for the ```desktop-qtile-config```
```bash
cd ~/git/dotfiles/desktop
```
```bash
stow -t ~ .
```
### Laptop
Create the symlinks for the ```laptop-qtile-config```

```bash
cd ~/git/dotfiles/latop
```
```bash
stow -t ~ .
```
