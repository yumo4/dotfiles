{
  pkgs,
  config,
  ...
}: let
  baseDomain = "yumo4.duckdns.org";
  subDomain = "syncthing";
  localDomain = "homeone";
  port = 8384;
  username = "max";
in {
  environment.systemPackages = with pkgs; [
    syncthing
  ];

  networking.firewall = {
    allowedTCPPorts = [port];
  };
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    user = username;
    group = "users";
    guiAddress = "0.0.0.0:${toString port}";
    # guiAddress = "127.0.0.1:${toString port}";
    configDir = "/home/${username}/.config/syncthing";
    # dataDir = "/var/lib/syncthing";
    dataDir = "/home/${username}/.local/share/syncthing";
  };

  homelab.services.syncthing = {
    homepage = {
      name = "Syncthing";
      description = "";
      icon = "syncthing.svg";
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

    virtualHosts."${subDomain}.${localDomain}" = {
      extraConfig = ''
        reverse_proxy http://127.0.0.1:${toString port}
      '';
    };
  };
}
