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
  # downloadDir = "/mnt/nebulon-b-01/Media/Downloads";
  secretspath = builtins.toString inputs.mysecrets;
in {
  imports = [
    inputs.sops-nix.nixosModules.sops
    # inputs.vpn-confinement.nixosModules.default
  ];

  sops = {
    defaultSopsFile = "${secretspath}/secrets.yaml";
    validateSopsFiles = false;

    secrets = {
      "protonvpn-wg-arr-config" = {};
    };
  };

  environment.systemPackages = with pkgs; [
    qbittorrent
    qbittorrent-nox
    wireguard-tools
    iproute2
    tcpdump
    socat
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

  # vpnNamespaces.qbtvpn = {
  #   enable = true;
  #   wireguardConfigFile = config.sops.secrets."protonvpn-wg-arr-config".path;
  #
  #   portMappings = [
  #     {
  #       from = port;
  #       to = port;
  #       protocol = "tcp";
  #     }
  #   ];
  #
  #   openVPNPorts = [
  #     {
  #       port = 6881;
  #       protocol = "tcp";
  #     }
  #     {
  #       port = 6881;
  #       protocol = "udp";
  #     }
  #   ];
  # };
  # systemd.services.qbittorrent.vpnConfinement = {
  #   enable = true;
  #   vpnNamespaces = "qbtvpn";
  # };

  homelab.services.qbittorrent = {
    homepage = {
      name = "qBittorrent";
      description = "";
      icon = "qbittorrent.svg";
      category = "Arr";
    };
    url = "${subDomain}.${baseDomain}";
  };

  # Caddy reverse proxy
  services.caddy = {
    virtualHosts."${subDomain}.${baseDomain}" = {
      useACMEHost = baseDomain;

      # reverse_proxy http://127.0.0.1:${toString port}
      extraConfig = ''
        reverse_proxy http://192.168.15.1:${toString port}
      '';
    };
  };
}
