{pkgs, ...}: {
  imports = [
    ./bat.nix
    ./btop.nix
    ./fish.nix
    ./git.nix
    ./ohmyposh.nix
    ./shell.nix
    ./tmux.nix
  ];
}
