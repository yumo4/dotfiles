{
  pkgs,
  config,
  ...
}: let
  baseDomain = "yumo4.dev";
  subDomain = "qbit";
  port = 8112;
in {
  environment.systemPackages = with pkgs; [
    qbittorrent
  ];

  services.qbittorrent = {
    enable = true;
    openFirewall = true;
    user = "max";
    group = "users";
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

  services.caddy = {
    virtualHosts."${subDomain}.${baseDomain}" = {
      useACMEHost = baseDomain;

      extraConfig = ''
        reverse_proxy http://127.0.0.1:${toString port}
      '';
    };
  };
}
