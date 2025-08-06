{
  pkgs,
  config,
  ...
}: let
  baseDomain = "yumo4.dev";
  subDomain = "sonarr";
  port = 8989;
in {
  environment.systemPackages = with pkgs; [
    sonarr
  ];

  services.sonarr = {
    enable = true;
    openFirewall = true;
    user = "max";
    group = "users";
  };

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
