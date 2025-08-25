{
  pkgs,
  config,
  ...
}: let
  baseDomain = "yumo4.dev";
  subDomain = "prowlarr";
  port = 9696;

  mediaDir = "/mnt/nebulon-b-01/Media";
in {
  virtualisation.oci-containers.containers = {
    prowlarr = {
      image = "lscr.io/linuxserver/prowlarr:latest";
      autoStart = true;
      volumes = [
        "/var/lib/prowlarr/:/config"
        "${mediaDir}:/media"
      ];
      environment = {
        PUID = "1000";
        GUID = "100";
        TZ = "Europe/Berlin";
      };
      # ports = [
      #   "${toString port}:${toString port}"
      # ];
      extraOptions = [
        "--network=container:gluetun"
      ];
      dependsOn = ["gluetun"];
    };
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/prowlarr 0755 max users -"
  ];

  homelab.services.prowlarr = {
    homepage = {
      name = "Prowlarr";
      description = "";
      icon = "prowlarr.svg";
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
