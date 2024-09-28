#!/bin/sh
# installing yay 
if ! command -v yay >/dev/null 2>&1; then
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd ..
    rm -rf yay
fi

# Detect CPU vendor
cpu_vendor=$(grep -m 1 'vendor_id' /proc/cpuinfo | awk '{print $3}')

# Install microcode package depending on CPU vendor
case $cpu_vendor in
    GenuineIntel)
        microcode_package="intel-ucode"
        ;;
    AuthenticAMD)
        microcode_package="amd-ucode"
        ;;
    *)
        microcode_package=""
        ;;
esac

# Update system and install packages
yay -Syu --needed --noconfirm \
	${microcode_package} \
	acpi acpi_call acpid \
	alacritty alsa-utils \
	arandr aquamarine-git blueman bluez \
	brave-bin brillo btop calibre \
	cups fastfetch flameshot forticlient-vpn \
	fzf go gst-plugin-pipewire hplip hyprwayland-scanner-git \
	hyprland-git hyprpaper-git lsd luarocks lxappearance-gtk3 neovim \
	networkmanager nitrogen nodejs noto-fonts noto-fonts-emoji \
	npm obsidian oh-my-posh openresolv p7zip p7zip-gui \
	pavucontrol pcmanfm pika-backup pipewire pipewire-alsa \
	pipewire-jack pipewire-pulse playerctl \
	python-iwlib qtile redshift rofi \
	syncthing system-config-printer texlive thunar tmux \
	tree tree-sitter-cli ttf-jetbrains-mono \
	ttf-jetbrains-mono-nerd ttf-nerd-fonts-symbols \
	ttf-nerd-fonts-symbols-mono typescript-language-server \
	vesktop vlc waybar wireguard-tools wl-clipboard xclip zen-browser-bin zoxide zsh

# installing tmux tpm
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
