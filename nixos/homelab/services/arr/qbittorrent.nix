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
  ];
  systemd.services.qbittorrent-port-sync = {
    description = "Sync gluetun forwarded port to qBittorrent on startup";

    after = ["podman-gluetun.service"];
    before = ["podman-qbittorrent.service"];

    wantedBy = ["podman-qbittorrent.service"];

    serviceConfig = {
      Type = "oneshot";
    };

    script = ''
      set -e

      echo "Waiting for gluetun to be ready..."
      for i in {1..30}; do
        if podman exec gluetun cat /tmp/gluetun/forwarded_port 2>/dev/null; then
          break
        fi
        sleep 1
      done

      PORT=$(podman exec gluetun cat /tmp/gluetun/forwarded_port)
      echo "Found forwarded port: $PORT"

      # Update qBittorrent config
      podman exec qbittorrent sed -i "s/^Session\\\\Port=.*/Session\\\\Port=$PORT/" /config/qBittorrent/qBittorrent.conf

      echo "Updated qBittorrent config to use port: $PORT"
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
