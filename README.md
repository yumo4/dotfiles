# Dotfiles
## Requirements
### Git
```
pacman -S git
```
### Stow
```
pacman -S stow
```
## Installation
Clone the repo
```
cd ~/git
git clone git@github.com:MaximilianTroester/dotfiles.git
cd ~/dotfiles 
```
then create the stow symlinks
```
cd ~/git/dotfiles/common
stow -t ~ .
```
### desktop
```
cd ~/git/dotfiles/desktop
stow -t ~ .
```
### latop
```
cd ~/git/dotfiles/latop
stow -t ~ .
```
