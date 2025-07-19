{pkgs, ...}: let
  baseDomain = "yumo4.dev";
  subDomain = "pdf";
  port = 8085;
in {
  environment.systemPackages = with pkgs; [
    stirling-pdf
  ];

  networking.firewall = {
    allowedTCPPorts = [port];
  };
  services.stirling-pdf = {
    enable = true;
    environment = {
      INSTALL_BOOK_AND_ADVANCED_HTML_OPS = "true";
      SERVER_PORT = port;
    };
  };

  homelab.services.stirling-pdf = {
    homepage = {
      name = "Stirling PDF";
      description = "";
      icon = "stirling-pdf.svg";
      category = "Services";
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
