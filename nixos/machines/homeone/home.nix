{
  config,
  pkgs,
  ...
}: let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in {
  imports = [
  ];
  home.username = "max";
  home.homeDirectory = "/home/max";
  home.shell.enableFishIntegration = true;
  home.shellAliases = {
    vi = "nvim";
    vim = "nvim";
    fetch = "fastfetch";
    ls = "lsd";
    ll = "lsd -l";
    lst = "tree -C";
    cat = "bat";
    tas = "tmux attach-session -t";
    home-one = "ssh max@192.168.178.65";
  };

  xdg.enable = true;
  xdg.configFile.nvim.source = mkOutOfStoreSymlink "/home/max/Projects/dotfiles/dots/.config/nvim";

  home.file = {
    ".zshrc".source = ../../../dots/.zshrc;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs = {
    btop = import ../../home/btop.nix {inherit pkgs;};
    fish = import ../../home/fish.nix {inherit pkgs;};
    git = import ../../home/git.nix {inherit pkgs;};
    tmux = import ../../home/tmux.nix {inherit pkgs;};
    zoxide = import ../../home/zoxide.nix {inherit pkgs;};
  };

  # services = {
  #   syncthing = import ../../home/syncthing.nix {inherit pkgs;};
  # };

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
