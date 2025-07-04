{pkgs, ...}: let
  baseDomain = "yumo4.duckdns.org";
in {
  environment.systemPackages = with pkgs; [
    caddy
  ];

  networking.firewall.allowedTCPPorts = [80 443];
  services.caddy = {
    enable = true;
    # virtualHosts."${domain}".extraConfig = ''
    #   respond "OK"
    # '';
    # globalConfig = ''
    #   auto_https off
    # '';
    virtualHosts = {
      "http://${baseDomain}" = {
        extraConfig = ''
          redir https://{host}{uri}
        '';
      };

      "http://*.${baseDomain}" = {
        extraConfig = ''
          redir https://{host}{uri}
        '';
      };
    };
  };
}
