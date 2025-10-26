{
  config,
  pkgs,
  pkgs-stable,
  lib,
  meta,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    ../../modules/core

    ../../modules/optional/gui.nix
    ../../modules/optional/kanata.nix
    ../../modules/optional/latex.nix
    ../../modules/optional/printing.nix
    ../../modules/optional/sops.nix
    ../../modules/optional/tailscale.nix
    ../../modules/optional/udev-brightnesskeys.nix
    ../../modules/optional/zsa.nix
  ];

  networking.hostName = meta.hostname;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  programs.firefox.enable = true;
  hardware.brillo.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages =
    (with pkgs; [
      # vesktop
      calibre
      libation # audible
      syncthing
      vscodium-fhs
      teams-for-linux
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
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "25.11";
}
