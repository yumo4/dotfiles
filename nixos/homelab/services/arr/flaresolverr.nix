{
  pkgs,
  config,
  ...
}: let
  baseDomain = "yumo4.dev";
  port = 8191;
in {
  virtualisation.oci-containers.containers = {
    flaresolverr = {
      image = "ghcr.io/flaresolverr/flaresolverr:latest";
      autoStart = true;
      environment = {
        LOG_LEVEL = "info";
        CAPTCHA_SOLVER = "none";
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
    "d /var/lib/flaresolverr 0755 max users -"
  ];

  homelab.services.flaresolverr = {
    homepage = {
      name = "Flaresolverr";
      description = "";
      icon = "flaresolverr.svg";
      category = "Arr";
    };
    url = "flaresolverr.${baseDomain}";
  };

  services.caddy = {
    virtualHosts."flaresolverr.${baseDomain}" = {
      useACMEHost = baseDomain;
      extraConfig = ''
        reverse_proxy http://127.0.0.1:${toString port}
      '';
    };
  };
}
