{pkgs, ...}: {
  imports = [
    ../../home/core

    ../../home/optional/ghostty.nix
    ../../home/optional/gui.nix
    ../../home/optional/hyprland.nix
    ../../home/optional/hyprlock.nix
    # ../../home/optional/hypridle.nix
    ../../home/optional/niri
    ../../home/optional/vicinae.nix
    ../../home/optional/sherlock.nix
    ../../home/optional/ssh.nix
    ../../home/optional/syncthing.nix
    ../../home/optional/waybar.nix

    ../../home/optional/zed.nix
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
    ".ideavimrc".source = ../../../dots/.ideavimrc;
    ".config/rofi".source = ../../../dots/.config/rofi;
    ".config/fastfetch".source = ../../../dots/.config/fastfetch;
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
