{
  pkgs,
  config,
  ...
}: let
  baseDomain = "yumo4.dev";
  subDomain = "books";
  dataDir = "/var/lib/calibre-web";
  port = 8083;
in {
  environment.systemPackages = with pkgs; [
    calibre-web
  ];

  services.calibre-web = {
    enable = true;
    openFirewall = true;
    listen = {
      ip = "127.0.0.1";
      port = port;
    };
    # user = "max";
    dataDir = dataDir;
  };

  fileSystems."/var/lib/calibre-web/books" = {
    device = "/mnt/nebulon-b-01/Media/Books";
    options = ["bind"];
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/calibre-web 0755 calibre-web calibre-web -"
  ];

  homelab.services.calibre-web = {
    homepage = {
      name = "Calibre";
      description = "";
      icon = "calibre.svg";
      category = "Media";
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
