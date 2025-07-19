{
  config,
  pkgs,
  lib,
  meta,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    ../../modules/core
    ./samba
    ../../modules/optional/tailscale.nix

    ../../homelab/core/acme.nix
    ../../homelab/core/caddy.nix

    ../../homelab/services/adguard.nix
    ../../homelab/services/audiobookshelf.nix
    ../../homelab/services/homepage.nix
    ../../homelab/services/jellyfin.nix
    ../../homelab/services/paperless.nix
    ../../homelab/services/stirling-pdf.nix
    ../../homelab/services/syncthing.nix
    ../../homelab/services/uptime-kuma.nix
    ../../homelab/services/vaultwarden.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = meta.hostname;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  programs.fish.enable = true;
  programs.zsh.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    inetutils
    dnsutils
  ];

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

  system.stateVersion = "24.05";
}
