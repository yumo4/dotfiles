{pkgs, ...}: let
  baseDomain = "yumo4.dev";
in {
  environment.systemPackages = with pkgs; [
    caddy
  ];

  networking.firewall.allowedTCPPorts = [80 443];
  services.caddy = {
    enable = true;
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
