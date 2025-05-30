{
  config,
  pkgs,
  pkgs-stable,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    ../../modules/core.nix
    ../../modules/gc.nix
    ../../modules/gui.nix
    ../../modules/languages.nix
    ../../modules/latex.nix
    ../../modules/locales.nix
    ../../modules/user.nix
    ../../modules/zsa.nix
  ];

  # NOTE: -> ?
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "chimaera";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # NOTE: -> ?
  programs.firefox.enable = true;
  programs.fish.enable = true;
  programs.zsh.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages =
    (with pkgs; [
      # pika-backup
      # vesktop
      calibre
      libation # audible
      orca-slicer
      syncthing
      vscodium-fhs
    ])
    ++ (with pkgs-stable; [
      protonvpn-gui
      protonvpn-cli
      wireguard-go
      wireguard-tools
    ]);

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true; programs.gnupg.agent = { enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "24.05";
}
