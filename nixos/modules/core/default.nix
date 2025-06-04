{
  inputs,
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [
    ./packages.nix
    ./gc.nix
    ./languages.nix
    ./locales.nix
    ./user.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.networkmanager.enable = true;

  programs.fish.enable = true;
  programs.zsh.enable = true;
}
