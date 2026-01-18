{
  pkgs,
  config,
  ...
}: let
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
}
