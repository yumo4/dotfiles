{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services.qbittorrent;

  # Generate only non-null settings dynamically
  generateConfig = attrs:
    concatStringsSep "\n\n" (
      mapAttrsToList (
        section: keys: let
          lines = mapAttrsToList (
            key: value: "${key}=${
              if isBool value
              then
                (
                  if value
                  then "true"
                  else "false"
                )
              else if isList value
              then concatStringsSep ", " (map toString value)
              else toString value
            }"
          ) (filterAttrs (_: v: v != null) keys);
        in
          if lines == []
          then ""
          else "[${section}]\n" + concatStringsSep "\n" lines
      ) (filterAttrs (_: v: v != {}) attrs)
    );

  # Create the qBittorrent configuration file
  qbittorrentConf = pkgs.writeText "qBittorrent.conf" (generateConfig {
    BitTorrent = filterAttrs (_: v: v != null) {
      "Session\\BTProtocol" = cfg.bittorrent.protocol;
      "Session\\Port" = cfg.bittorrent.port;
      "Session\\GlobalDLSpeedLimit" = cfg.bittorrent.globalDownloadSpeedLimit;
      "Session\\GlobalUPSpeedLimit" = cfg.bittorrent.globalUploadSpeedLimit;
      "Session\\Interface" = cfg.bittorrent.interface;
      "Session\\InterfaceName" = cfg.bittorrent.interfaceName;
      "Session\\Preallocation" = cfg.bittorrent.preallocation;
      "Session\\QueueingSystemEnabled" = cfg.bittorrent.queueingEnabled;
      "Session\\MaxActiveDownloads" = cfg.bittorrent.maxActiveDownloads;
      "Session\\MaxActiveTorrents" = cfg.bittorrent.maxActiveTorrents;
      "Session\\MaxActiveUploads" = cfg.bittorrent.maxActiveUploads;
      "Session\\DefaultSavePath" = cfg.bittorrent.defaultSavePath;
      "Session\\DisableAutoTMMByDefault" = cfg.bittorrent.disableAutoTMMByDefault;
      "Session\\DisableAutoTMMTriggers\\CategorySavePathChanged" = cfg.bittorrent.disableAutoTMMTriggersCategorySavePathChanged;
      "Session\\DisableAutoTMMTriggers\\DefaultSavePathChanged" = cfg.bittorrent.disableAutoTMMTriggersDefaultSavePathChanged;
      "Session\\ExcludedFileNamesEnabled" = cfg.bittorrent.excludedFileNamesEnabled;
      "Session\\ExcludedFileNames" = cfg.bittorrent.excludedFileNames;
      "Session\\FinishedTorrentExportDirectory" = cfg.bittorrent.finishedTorrentExportDirectory;
      "Session\\SubcategoriesEnabled" = cfg.bittorrent.subcategoriesEnabled;
      "Session\\TempPath" = cfg.bittorrent.tempPath;
    };

    Core = filterAttrs (_: v: v != null) {
      "AutoDeleteAddedTorrentFile" = cfg.core.autoDeleteTorrentFile;
    };

    Network = filterAttrs (_: v: v != null) {
      "PortForwardingEnabled" = cfg.network.portForwardingEnabled;
    };

    Preferences = filterAttrs (_: v: v != null) {
      "WebUI\\LocalHostAuth" = cfg.webUI.localHostAuth;
      "WebUI\\AuthSubnetWhitelist" = cfg.webUI.authSubnetWhitelist;
      "WebUI\\AuthSubnetWhitelistEnabled" = cfg.webUI.authSubnetWhitelistEnabled;
      "WebUI\\Username" = cfg.webUI.username;
      "WebUI\\Port" = cfg.webUI.port;
      "WebUI\\Password_PBKDF2" = cfg.webUI.password;
      "WebUI\\CSRFProtection" = cfg.webUI.csrfProtection;
      "WebUI\\ClickjackingProtection" = cfg.webUI.clickjackingProtection;
    };
  });
in {
  options.services.qbittorrent = {
    enable = mkEnableOption "qBittorrent daemon";

    package = mkOption {
      type = types.package;
      default = pkgs.qbittorrent-nox;
      defaultText = literalExpression "pkgs.qbittorrent-nox";
      description = "qBittorrent package to use";
    };

    user = mkOption {
      type = types.str;
      default = "qbittorrent";
      description = "User to run qBittorrent as";
    };

    group = mkOption {
      type = types.str;
      default = "qbittorrent";
      description = "Group to run qBittorrent as";
    };

    dataDir = mkOption {
      type = types.path;
      default = "/var/lib/qbittorrent";
      description = "Directory to store qBittorrent data";
    };

    bittorrent = {
      protocol = mkOption {
        type = types.nullOr (types.enum ["Both" "TCP" "uTP"]);
        default = null;
        description = "BitTorrent protocol to use";
      };

      port = mkOption {
        type = types.nullOr types.port;
        default = null;
        description = "Port for BitTorrent connections";
      };

      globalDownloadSpeedLimit = mkOption {
        type = types.nullOr types.int;
        default = null;
        description = "Global download speed limit in KiB/s (0 = unlimited)";
      };

      globalUploadSpeedLimit = mkOption {
        type = types.nullOr types.int;
        default = null;
        description = "Global upload speed limit in KiB/s (0 = unlimited)";
      };

      interface = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Network interface to bind to";
      };

      interfaceName = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Network interface name to bind to";
      };

      preallocation = mkOption {
        type = types.nullOr types.bool;
        default = null;
        description = "Enable file preallocation";
      };

      queueingEnabled = mkOption {
        type = types.nullOr types.bool;
        default = null;
        description = "Enable torrent queuing system";
      };

      maxActiveDownloads = mkOption {
        type = types.nullOr types.int;
        default = null;
        description = "Maximum number of active downloads";
      };

      maxActiveTorrents = mkOption {
        type = types.nullOr types.int;
        default = null;
        description = "Maximum number of active torrents";
      };

      maxActiveUploads = mkOption {
        type = types.nullOr types.int;
        default = null;
        description = "Maximum number of active uploads";
      };

      defaultSavePath = mkOption {
        type = types.nullOr types.path;
        default = null;
        description = "Default path to save downloaded files";
      };

      disableAutoTMMByDefault = mkOption {
        type = types.nullOr types.bool;
        default = null;
        description = "Disable automatic torrent management by default";
      };

      disableAutoTMMTriggersCategorySavePathChanged = mkOption {
        type = types.nullOr types.bool;
        default = null;
        description = "Disable auto TMM when category save path changes";
      };

      disableAutoTMMTriggersDefaultSavePathChanged = mkOption {
        type = types.nullOr types.bool;
        default = null;
        description = "Disable auto TMM when default save path changes";
      };

      excludedFileNamesEnabled = mkOption {
        type = types.nullOr types.bool;
        default = null;
        description = "Enable excluded file names filter";
      };

      excludedFileNames = mkOption {
        type = types.nullOr (types.listOf types.str);
        default = null;
        description = "List of file name patterns to exclude";
      };

      finishedTorrentExportDirectory = mkOption {
        type = types.nullOr types.path;
        default = null;
        description = "Directory to export finished torrents to";
      };

      subcategoriesEnabled = mkOption {
        type = types.nullOr types.bool;
        default = null;
        description = "Enable subcategories";
      };

      tempPath = mkOption {
        type = types.nullOr types.path;
        default = null;
        description = "Path for temporary files";
      };
    };

    core = {
      autoDeleteTorrentFile = mkOption {
        type = types.nullOr types.bool;
        default = null;
        description = "Automatically delete torrent files after adding";
      };
    };

    network = {
      portForwardingEnabled = mkOption {
        type = types.nullOr types.bool;
        default = null;
        description = "Enable UPnP/NAT-PMP port forwarding";
      };
    };

    webUI = {
      localHostAuth = mkOption {
        type = types.nullOr types.bool;
        default = null;
        description = "Enable authentication for localhost";
      };

      authSubnetWhitelist = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Subnet whitelist for bypassing authentication";
      };

      authSubnetWhitelistEnabled = mkOption {
        type = types.nullOr types.bool;
        default = null;
        description = "Enable subnet whitelist for authentication bypass";
      };

      username = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "WebUI username";
      };

      port = mkOption {
        type = types.nullOr types.port;
        default = null;
        description = "WebUI port";
      };

      password = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "WebUI password (PBKDF2 hash)";
      };

      csrfProtection = mkOption {
        type = types.nullOr types.bool;
        default = null;
        description = "Enable CSRF protection";
      };

      clickjackingProtection = mkOption {
        type = types.nullOr types.bool;
        default = null;
        description = "Enable clickjacking protection";
      };
    };
  };

  config = mkIf cfg.enable {
    users.users = mkIf (cfg.user == "qbittorrent") {
      qbittorrent = {
        group = cfg.group;
        home = cfg.dataDir;
        createHome = true;
        description = "qBittorrent daemon user";
        isSystemUser = true;
      };
    };

    users.groups = mkIf (cfg.group == "qbittorrent") {
      qbittorrent = {};
    };

    systemd.services.qbittorrent = {
      description = "qBittorrent daemon";
      after = ["network.target"];
      wantedBy = ["multi-user.target"];

      serviceConfig = {
        Type = "exec";
        User = cfg.user;
        Group = cfg.group;
        ExecStart = "${cfg.package}/bin/qbittorrent-nox --configuration=${cfg.dataDir}";
        Restart = "on-failure";
        RestartSec = 5;

        # Security settings
        NoNewPrivileges = true;
        PrivateTmp = true;
        ProtectSystem = "strict";
        ProtectHome = true;
        ReadWritePaths = [cfg.dataDir];
        ProtectKernelTunables = true;
        ProtectKernelModules = true;
        ProtectControlGroups = true;
      };

      preStart = ''
        mkdir -p ${cfg.dataDir}/.config/qBittorrent
        cp ${qbittorrentConf} ${cfg.dataDir}/.config/qBittorrent/qBittorrent.conf
        chown -R ${cfg.user}:${cfg.group} ${cfg.dataDir}
      '';
    };

    # Open firewall ports if specified
    networking.firewall = mkMerge [
      (mkIf (cfg.bittorrent.port != null) {
        allowedTCPPorts = [cfg.bittorrent.port];
        allowedUDPPorts = [cfg.bittorrent.port];
      })
      (mkIf (cfg.webUI.port != null) {
        allowedTCPPorts = [cfg.webUI.port];
      })
    ];
  };
}
