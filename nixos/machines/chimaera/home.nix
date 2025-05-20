{
  config,
  pkgs,
  ...
}: let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in {
  home.username = "max";
  home.homeDirectory = "/home/max";
  home.pointerCursor = {
    x11.enable = true;
    gtk.enable = true;
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24;
  };
  home.shell.enableFishIntegration = true;
  home.shellAliases = {
    vi = "nvim";
    vim = "nvim";
    fetch = "fastfetch";
    ls = "lsd";
    ll = "lsd -l";
    lst = "tree -C";
    tas = "tmux attach-session -t";
    home-one = "ssh max@192.168.178.65";
  };

  xdg.enable = true;
  xdg.configFile.nvim.source = mkOutOfStoreSymlink "/home/max/Projects/dotfiles/dots/.config/nvim";

  home.file = {
    ".zshrc".source = ../dots/.zshrc;
    ".ideavimrc".source = ../dots/.ideavimrc;
    ".config/alacritty".source = ../dots/.config/alacritty;
    ".config/fastfetch".source = ../dots/.config/fastfetch;
    ".config/rofi".source = ../dots/.config/rofi;

    ".themes/Gruvbox-Material-Dark".source = ../dots/.themes/Gruvbox-Material-Dark;
    ".icons/Gruvbox-Material-Dark".source = ../dots/.icons/Gruvbox-Material-Dark;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    XCURSOR_SIZE = "24";
    XCURSOR_THEME = "Adwaita";

    GTK_THEME = "Adwaita-dark";
  };

  programs = {
    btop = import ../../home/btop.nix {inherit pkgs;};
    fish = import ../../home/fish.nix {inherit pkgs;};
    ghostty = import ../../home/ghostty.nix {inherit pkgs;};
    git = import ../../home/git.nix {inherit pkgs;};
    gui = import ../../home/gui.nix {inherit pkgs;};
    hyprlock = import ../../home/hyprlock.nix {inherit pkgs;};
    tmux = import ../../home/tmux.nix {inherit pkgs;};
    waybar = import ../../home/waybar.nix {inherit pkgs;};
    zoxide = import ../../home/zoxide.nix {inherit pkgs;};
  };

  services = {
    syncthing = import ../../home/syncthing.nix;
  };

  wayland.windowManager = {
    hyprland = import ./home/hyprland.nix {inherit pkgs;};
  };

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
