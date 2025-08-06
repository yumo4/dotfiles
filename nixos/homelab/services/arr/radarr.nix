{
  pkgs,
  config,
  ...
}: let
  baseDomain = "yumo4.dev";
  subDomain = "radarr";
  port = 7878;
in {
  environment.systemPackages = with pkgs; [
    radarr
  ];

  services.radarr = {
    enable = true;
    openFirewall = true;
    user = "max";
    group = "users";
  };

  homelab.services.radarr = {
    homepage = {
      name = "Radarr";
      description = "";
      icon = "radarr.svg";
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
