{pkgs, ...}: let
  baseDomain = "yumo4.duckdns.org";
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
