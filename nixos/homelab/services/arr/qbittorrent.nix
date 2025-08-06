{
  pkgs,
  config,
  inputs,
  lib,
  ...
}: let
  baseDomain = "yumo4.dev";
  subDomain = "qbt";
  port = 8112;
  downloadDir = "/mnt/nebulon-b-01/Media/Downloads";
  secretspath = builtins.toString inputs.mysecrets;
in {
  imports = [inputs.sops-nix.nixosModules.sops];

  sops = {
    defaultSopsFile = "${secretspath}/secrets.yaml";
    validateSopsFiles = false;

    secrets = {
      # "protonvpn-wg-publickey" = {};
      # "protonvpn-wg-privatekey" = {};
      # "protonvpn-wg-endpoint" = {};

      # "qbittorrent/web-password" = {};
    };
  };

  environment.systemPackages = with pkgs; [
    qbittorrent-nox
    wireguard-tools
    iproute2
  ];

  services.qbittorrent = {
    enable = true;
    user = "max";
    group = "users";
    openFirewall = true;

    torrentingPort = 6881;
    webuiPort = port;

    extraArgs = [
      "--confirm-legal-notice"
    ];
  };

  # Enable IP forwarding for network namespaces
  homelab.services.qbittorrent = {
    homepage = {
      name = "qBittorrent";
      description = "BitTorrent client with VPN";
      icon = "qbittorrent.svg";
      category = "Media";
    };
    url = "${subDomain}.${baseDomain}";
  };

  # Caddy reverse proxy
  services.caddy = {
    virtualHosts."${subDomain}.${baseDomain}" = {
      useACMEHost = baseDomain;

      extraConfig = ''
        reverse_proxy http://127.0.0.1:${toString port}
      '';
    };
  };
}
