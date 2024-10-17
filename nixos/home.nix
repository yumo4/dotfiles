{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "max";
  home.homeDirectory = "/home/max";
  home.pointerCursor = {
    x11.enable = true;
    gtk.enable = true;
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24;
  };

  # xdg.enable = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".zshrc".source = ../dots/.zshrc;
    ".ideavimrc".source = ../dots/.ideavimrc;
    ".config/nvim".source = ../dots/.config/nvim;
    # ".config/tmux".source = ../dots/.config/tmux;
    ".config/tmux".source = ~/Projects/dotfiles/dots/.config/tmux;
    ".config/alacritty".source = ../dots/.config/alacritty;
    ".config/fastfetch".source = ../dots/.config/fastfetch;
    ".config/flameshot".source = ../dots/.config/flameshot;
    ".config/ohmyposh".source = ../dots/.config/ohmyposh;
    ".config/fish".source = ../dots/.config/fish;
    # ".config/starship".source = ../dots/.config/starship;
    ".config/qtile".source = ../dots/.config/qtile;
    ".config/hypr".source = ../dots/.config/hypr;
    ".config/rofi".source = ../dots/.config/rofi;


    ".themes/Gruvbox-Material-Dark".source = ../dots/.themes/Gruvbox-Material-Dark;
    ".icons/Gruvbox-Material-Dark".source = ../dots/.icons/Gruvbox-Material-Dark;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.git = {
    enable = true;
    userName = "yumo4";
    userEmail = "maximilian.troe@gmail.com";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };

  services.syncthing = {
    enable = true;
  };

  programs.btop = {
    enable = true;
    settings.color_theme = "gruvbox_material_dark";
  };

  qt = {
    enable = true;
  };

  gtk = {
      enable = true;
      gtk3.extraConfig = {
          gtk-application-prefer-dark-theme = true;
      };
      theme.name = "Gruvbox-Material-Dark";
      iconTheme.name = "Gruvbox-Material-Dark";
      font.name = "JetBrainsMono Nerd Font";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
