{pkgs, ...}: {
  imports = [
    ./bat.nix
    ./btop.nix
    ./fish.nix
    ./git.nix
    ./nvim.nix
    ./ohmyposh.nix
    ./shell.nix
    ./tmux.nix
    ./zoxide.nix
  ];
}
