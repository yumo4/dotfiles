{
  pkgs,
  config,
  ...
}: let
  baseDomain = "yumo4.dev";
  subDomain = "qbit";
  port = 8112;

  # Define your directories (adjust these paths to match your setup)
  # mediaDir = "/media";
  mediaDir = "/mnt/nebulon-b-01/Media";
in {
  imports = [
    ../../../modules/custom/qbittorrent/default.nix
  ];
  environment.systemPackages = with pkgs; [
    qbittorrent
  ];

  # qBittorrent service configuration using your custom module
  services.qbittorrent = {
    enable = true;
    user = "max";
    group = "users";
    configDir = "/var/lib/qbittorrent";

    bittorrent = {
      protocol = "TCP";
      globalDownloadSpeedLimit = 6500; # 6.5 MB/s
      globalUploadSpeedLimit = 2000; # 2 MB/s
      interface = "wg-mullvad"; # VPN interface
      interfaceName = "wg-mullvad"; # VPN interface name
      preallocation = true;
      queueingEnabled = false;
      defaultSavePath = "${mediaDir}/Downloads";
      disableAutoTMMByDefault = false;
      disableAutoTMMTriggersCategorySavePathChanged = false;
      disableAutoTMMTriggersDefaultSavePathChanged = false;
      finishedTorrentExportDirectory = "${mediaDir}/Downloads/complete";
      subcategoriesEnabled = true;
    };

    network = {
      portForwardingEnabled = false; # Disabled since using VPN
    };

    webUI = {
      port = port;
      username = "max";
      localHostAuth = false;
      csrfProtection = true;
      clickjackingProtection = true;
      authSubnetWhitelistEnabled = true;
      authSubnetWhitelist = "127.0.0.1/32"; # Allow localhost without auth for Caddy
    };
  };

  # # Create the media group if it doesn't exist
  # users.groups.media = {};
  #
  # # Ensure the qbittorrent user is part of the media group
  # users.users.qbittorrent = {
  #   extraGroups = ["media"];
  # };

  homelab.services.qbittorrent = {
    homepage = {
      name = "qBittorrent";
      description = "Torrent client with web interface";
      icon = "qbittorrent.svg";
      category = "Arr";
    };
    url = "${subDomain}.${baseDomain}";
  };

  services.caddy = {
    virtualHosts."${subDomain}.${baseDomain}" = {
      useACMEHost = baseDomain;

      extraConfig = ''
        reverse_proxy http://127.0.0.1:${toString port} {
          # Handle WebSocket connections for real-time updates
          header_up X-Forwarded-Proto {scheme}
          header_up X-Forwarded-For {remote}
          header_up X-Real-IP {remote}
        }
      '';
    };
  };
}
