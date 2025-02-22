{
  config,
  pkgs,
  ...
}: let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in {
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

  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
  ];

  xdg.enable = true;

  xdg.configFile.nvim.source = mkOutOfStoreSymlink "/home/max/Projects/dotfiles/dots/.config/nvim";
  xdg.configFile.ghostty.source = mkOutOfStoreSymlink "/home/max/Projects/dotfiles/dots/.config/ghostty";

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".zshrc".source = ../dots/.zshrc;
    ".ideavimrc".source = ../dots/.ideavimrc;
    ".config/alacritty".source = ../dots/.config/alacritty;
    ".config/fastfetch".source = ../dots/.config/fastfetch;
    ".config/flameshot".source = ../dots/.config/flameshot;
    ".config/ohmyposh".source = ../dots/.config/ohmyposh;
    # ".config/fish".source = ../dots/.config/fish;
    ".config/qtile".source = ../dots/.config/qtile;
    ".config/hypr".source = ../dots/.config/hypr;
    ".config/waybar".source = ../dots/.config/waybar;
    ".config/rofi".source = ../dots/.config/rofi;
    ".config/dunst".source = ../dots/.config/dunst;

    ".themes/Gruvbox-Material-Dark".source = ../dots/.themes/Gruvbox-Material-Dark;
    ".icons/Gruvbox-Material-Dark".source = ../dots/.icons/Gruvbox-Material-Dark;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.tmux = import ./home/tmux.nix {inherit pkgs;};

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

  programs.fish = {
    enable = true;
    shellInit = ''
      oh-my-posh init fish --config "$HOME/.config/ohmyposh/config.toml" | source
    '';
    loginShellInit = ''
      oh-my-posh init fish --config "$HOME/.config/ohmyposh/config.toml" | source
    '';
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
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    theme.name = "Gruvbox-Material-Dark";
    iconTheme.name = "Gruvbox-Material-Dark";
    font.name = "JetBrainsMono Nerd Font";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
