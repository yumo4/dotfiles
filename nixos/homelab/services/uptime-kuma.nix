{pkgs, ...}: let
  baseDomain = "yumo4.dev";
  subDomain = "uptime";
  port = 3001;
in {
  environment.systemPackages = with pkgs; [
    uptime-kuma
  ];

  networking.firewall = {
    allowedTCPPorts = [port];
  };
  services.uptime-kuma = {
    enable = true;
    settings = {
      PORT = toString port;
      HOST = "0.0.0.0";
    };
    # appriseSupport = false;
  };

  homelab.services.uptime-kuma = {
    homepage = {
      name = "Uptime Kuma";
      description = "";
      icon = "uptime-kuma.svg";
      category = "Network";
    };
    url = "${subDomain}.${baseDomain}";
  };

  services.caddy = {
    virtualHosts."${subDomain}.${baseDomain}" = {
      useACMEHost = baseDomain;

      # reverse_proxy http://localhost:${toString port}
      extraConfig = ''
        reverse_proxy http://127.0.0.1:${toString port}
      '';
    };
  };
}
