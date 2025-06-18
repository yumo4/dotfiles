{pkgs, ...}: let
  baseDomain = "yumo4.duckdns.org";
  subDomain = "ad";
  port = 3000;
  dnsPort = 53;
in {
  environment.systemPackages = with pkgs; [
    # inetutils
    # dnsutils
  ];

  networking.firewall = {
    allowedTCPPorts = [port dnsPort];
    allowedUDPPorts = [dnsPort];
  };

  services.adguardhome = {
    enable = true;
    openFirewall = false;
    host = "0.0.0.0";
    port = port;
    settings = {
      http = {
        address = "0.0.0.0:${toString port}";
        # address = "127.0.0.1:${toString port}";
      };
      dns = {
        bind_hosts = ["0.0.0.0"];
        port = dnsPort;
        upstream_dns = [
          "192.168.178.1"
          "1.1.1.1"
          "8.8.8.8"
        ];
        rewrites = [
          {
            domain = "${baseDomain}";
            answer = "192.168.178.65";
          }

          {
            domain = "*.${baseDomain}";
            answer = "192.168.178.65";
          }
        ];
      };
      filtering = {
        protection_enabled = true;
        filtering_enabled = true;
      };
    };
  };

  services.caddy = {
    virtualHosts."${subDomain}.${baseDomain}" = {
      useACMEHost = baseDomain;
      # reverse_proxy http://localhost:${toString port}
      extraConfig = ''
        reverse_proxy http://127.0.01:${toString port}
      '';
    };
  };
}
