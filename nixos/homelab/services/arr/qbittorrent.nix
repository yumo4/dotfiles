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
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    defaultSopsFile = "${secretspath}/secrets.yaml";
    validateSopsFiles = false;

    secrets = {
      "gluetun-env" = {};
      "qbittorrent-env" = {};
      "qbittorrent-password" = {};
    };
  };

  environment.systemPackages = with pkgs; [
    podman
    wireguard-tools
    iproute2
  ];

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings = {
      dns_enabled = false; #true;
    };
  };

  virtualisation.oci-containers.containers = {
    gluetun = {
      image = "qmcgaw/gluetun";
      autoStart = true;
      volumes = [
        "/var/lib/gluetun:/gluetun"
        "/var/lib/gluetun/tmp:/tmp/gluetun"
      ];
      # check with
      # sudo podman exec gluetun cat /tmp/gluetun/forwarded_port
      ports = [
        "${toString port}:${toString port}"
        # "6881:6881" # torrent old
        "55398:55398" # torrent
        # "6789:6789"
        "9696:9696" # prowlarr
        "8989:8989" # sonarr
        "7878:7878" # radarr
      ];
      environmentFiles = [config.sops.secrets."gluetun-env".path];
      extraOptions = [
        "--cap-add=NET_ADMIN"
        "--device=/dev/net/tun:/dev/net/tun"
        # "--network=arr"
        # "--ip=172.39.0.2"
        "--dns=127.0.0.1"
      ];
    };

    qbittorrent = {
      image = "lscr.io/linuxserver/qbittorrent:latest";
      autoStart = true;
      volumes = [
        "/var/lib/qbittorrent/:/config"
        "${downloadDir}:/downloads"
      ];
      environmentFiles = [config.sops.secrets."qbittorrent-env".path];
      extraOptions = [
        # "--cap-add=NET_ADMIN"
        # "--device=/dev/net/tun:/dev/net/tun"
        "--network=container:gluetun"
        # "--ip=172.39.0.3"
      ];
      dependsOn = ["gluetun"];
    };
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/gluetun 0755 max users -"
    "d /var/lib/qbittorrent 0755 max users -"
    "d /var/lib/gluetun/tmp 0755 max users -"
  ];

  # Initial port sync on startup
  systemd.services.qbittorrent-port-sync = {
    description = "Sync gluetun forwarded port to qBittorrent on startup";

    after = ["podman-gluetun.service" "podman-qbittorrent.service"];

    wantedBy = ["multi-user.target"];

    serviceConfig = {
      Type = "oneshot";
    };

    script = ''
      set -e

      echo "Waiting for gluetun to be ready..."
      for i in {1..60}; do
        if [ -f /var/lib/gluetun/tmp/forwarded_port ] && [ -s /var/lib/gluetun/tmp/forwarded_port ]; then
          break
        fi
        sleep 1
      done

      PORT=$(cat /var/lib/gluetun/tmp/forwarded_port 2>/dev/null || echo "")

      if [ -z "$PORT" ]; then
        echo "ERROR: Could not read forwarded port"
        exit 1
      fi

      echo "Found forwarded port: $PORT"

      # Wait for qBittorrent WebUI to be ready
      echo "Waiting for qBittorrent WebUI..."
      for i in {1..60}; do
        if ${pkgs.curl}/bin/curl -s -o /dev/null -w "%{http_code}" "http://localhost:8112/api/v2/app/version" | grep -q "200\|403"; then
          break
        fi
        sleep 2
      done

      # Login and get cookie
      echo "Logging in to qBittorrent..."
      ${pkgs.curl}/bin/curl -s -c /tmp/qbt-cookies.txt -X POST "http://localhost:8112/api/v2/auth/login" \
      --data-urlencode "username=max" \
      --data-urlencode "password@${config.sops.secrets."qbittorrent-password".path}"

      # Update port via API
      echo "Setting port via API..."
      ${pkgs.curl}/bin/curl -s -b /tmp/qbt-cookies.txt -X POST "http://localhost:8112/api/v2/app/setPreferences" \
        -d "json={\"listen_port\":$PORT}"

      echo "Updated qBittorrent to use port: $PORT"
    '';
  };

  # Watch for port changes
  systemd.paths.qbittorrent-port-sync = {
    description = "Watch for gluetun port changes";
    wantedBy = ["multi-user.target"];
    pathConfig = {
      PathModified = "/var/lib/gluetun/tmp/forwarded_port";
      Unit = "qbittorrent-port-update.service";
    };
  };

  # Update port when it changes
  systemd.services.qbittorrent-port-update = {
    description = "Update qBittorrent with new forwarded port";

    serviceConfig = {
      Type = "oneshot";
    };

    script = ''
      set -e

      if [ ! -f /var/lib/gluetun/tmp/forwarded_port ]; then
        echo "Port file not found, skipping"
        exit 0
      fi

      PORT=$(cat /var/lib/gluetun/tmp/forwarded_port 2>/dev/null || echo "")

      if [ -z "$PORT" ]; then
        echo "Port is empty, skipping"
        exit 0
      fi

      echo "Detected new forwarded port: $PORT"

      # Login and get cookie
      ${pkgs.curl}/bin/curl -s -c /tmp/qbt-cookies.txt -X POST "http://localhost:8112/api/v2/auth/login" \
      --data-urlencode "username=max" \
      --data-urlencode "password@${config.sops.secrets."qbittorrent-password".path}"

      # Update port via API
      ${pkgs.curl}/bin/curl -s -b /tmp/qbt-cookies.txt -X POST "http://localhost:8112/api/v2/app/setPreferences" \
        -d "json={\"listen_port\":$PORT}"

      echo "Successfully updated qBittorrent to port: $PORT"
    '';
  };

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

      extraConfig = ''
        reverse_proxy http://127.0.0.1:${toString port}
      '';
    };
  };
}
