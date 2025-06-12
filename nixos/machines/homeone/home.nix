{pkgs, ...}: {
  imports = [
    ../../home/core

    ../../home/optional/sops.nix
    ../../home/optional/ssh.nix
    # ../../home/optional/syncthing.nix
  ];
  home.username = "max";
  home.homeDirectory = "/home/max";

  home.file = {
    ".config/fastfetch".source = ../../../dots/.config/fastfetch;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
