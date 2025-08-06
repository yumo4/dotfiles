{
  pkgs,
  config,
  ...
}: let
  baseDomain = "yumo4.dev";
  subDomain = "prowlarr";
  port = 9696;
in {
  environment.systemPackages = with pkgs; [
    prowlarr
  ];

  services.prowlarr = {
    enable = true;
    openFirewall = true;
  };

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
