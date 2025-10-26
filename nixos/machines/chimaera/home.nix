{pkgs, ...}: {
  imports = [
    ../../home/core

    # ../../home/optional/carapace.nix
    ../../home/optional/ghostty.nix
    ../../home/optional/gui.nix
    ../../home/optional/hyprland.nix
    ../../home/optional/hyprlock.nix
    ../../home/optional/niri
    ../../home/optional/hypridle.nix
    ../../home/optional/sherlock.nix
    ../../home/optional/sops.nix
    ../../home/optional/ssh.nix
    ../../home/optional/syncthing.nix
    ../../home/optional/waybar.nix

    ../../home/optional/zed.nix
    ../../home/optional/vicinae.nix
    # ../../home/optional/quickshell.nix
  ];
  home.username = "max";
  home.homeDirectory = "/home/max";
  home.pointerCursor = {
    x11.enable = true;
    gtk.enable = true;
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24;
  };

  home.file = {
    ".zshrc".source = ../../../dots/.zshrc;
    ".ideavimrc".source = ../../../dots/.ideavimrc;
    ".config/alacritty".source = ../../../dots/.config/alacritty;
    ".config/fastfetch".source = ../../../dots/.config/fastfetch;
    ".config/rofi".source = ../../../dots/.config/rofi;

    ".themes/Gruvbox-Material-Dark".source = ../../../dots/.themes/Gruvbox-Material-Dark;
    ".icons/Gruvbox-Material-Dark".source = ../../../dots/.icons/Gruvbox-Material-Dark;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    XCURSOR_SIZE = "24";
    XCURSOR_THEME = "Adwaita";

    GTK_THEME = "Adwaita-dark";
  };

  nixpkgs.config.allowUnfree = true;

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
