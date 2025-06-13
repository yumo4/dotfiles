{pkgs, ...}: let
  baseDomain = "yumo4.duckdns.org";
  subDomain = "uptime";
  port = "4042";
in {
  environment.systemPackages = with pkgs; [
    uptime-kuma
  ];

  services.uptime-kuma = {
    enable = true;
    settings = {
      PORT = port;
    };
    appriseSupport = false;
  };

  services.caddy = {
    virtualHosts."${subDomain}.${baseDomain}".extraConfig = ''
      reverse_proxy http://localhost:${port}
    '';
  };
}
