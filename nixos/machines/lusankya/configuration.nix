{
  config,
  pkgs,
  pkgs-stable,
  inputs,
  lib,
  meta,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    ../../modules/core

    ../../modules/optional/bluetooth.nix
    ../../modules/optional/docker.nix
    ../../modules/optional/kanata.nix
    ../../modules/optional/work.nix
    ../../modules/optional/gui.nix
    ../../modules/optional/printing.nix
    ../../modules/optional/tailscale.nix
  ];

  networking.hostName = meta.hostname;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages =
    (with pkgs; [
      # syncthing
      localsend
      chromium
      networkmanager-fortisslvpn
      openfortivpn
      openfortivpn-webview
      openssl
      cacert
    ])
    ++ (with pkgs-stable; [
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

  # virtualisation.podman = {
  #   enable = true;
  #   dockerCompat = true;
  # };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # security.pki.certificates = [
  security.pki.certificates = [
    (builtins.readFile /etc/nixos-secrets/flyeralarm-Root-CA.pem.crt)
    (builtins.readFile /etc/nixos-secrets/af.flyeralarm.crt)
  ];

  system.stateVersion = "24.05";
}
