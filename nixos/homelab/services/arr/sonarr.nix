{
  pkgs,
  config,
  ...
}: let
  baseDomain = "yumo4.dev";
  subDomain = "sonarr";
  port = 8989;

  mediaDir = "/mnt/nebulon-b-01/Media";
in {
  virtualisation.oci-containers.containers = {
    sonarr = {
      image = "lscr.io/linuxserver/sonarr:latest";
      autoStart = true;
      volumes = [
        "/var/lib/sonarr/:/config"
        # "${mediaDir}:/media"
        "/mnt/nebulon-b-01/Media:/media"
        "/mnt/nebulon-b-01/Media/Downloads:/downloads"
      ];
      environment = {
        PUID = "1000";
        GUID = "100";
        TZ = "Europe/Berlin";
      };
      ports = [
        "${toString port}:${toString port}"
      ];
      extraOptions = [
        "--network=container:gluetun"
      ];
      dependsOn = ["gluetun"];
    };
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/sonarr 0755 max users -"
    "d /mnt/nebulon-b-01/Media 0755 max users -"
    "d /mnt/nebulon-b-01/Media/Downloads 0755 max users -"
  ];

  homelab.services.sonarr = {
    homepage = {
      name = "Sonarr";
      description = "";
      icon = "sonarr.svg";
      category = "Arr";
    };
    url = "${subDomain}.${baseDomain}";
  };

  services.caddy = {
    virtualHosts."${subDomain}.${baseDomain}" = {
      useACMEHost = baseDomain;

      extraConfig = ''
        reverse_proxy http://127.0.0.1:${toString port}
      '';
    };
  };
}
