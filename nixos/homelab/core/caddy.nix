{pkgs, ...}: let
  domain = "yumo4.duckdns.org";
in {
  environment.systemPackages = with pkgs; [
    caddy
  ];

  networking.firewall.allowedTCPPorts = [80 443];
  services.caddy = {
    enable = true;
    virtualHosts."${domain}".extraConfig = ''
      respond "OK"
    '';
  };
}
