{
  pkgs,
  config,
  inputs,
  ...
}: let
  baseDomain = "yumo4.dev";
  subDomain = "feed";
  port = 8084;
  secretspath = builtins.toString inputs.mysecrets;
in {
  imports = [inputs.sops-nix.nixosModules.sops];
  sops = {
    defaultSopsFile = "${secretspath}/secrets.yaml";
    validateSopsFiles = false;

    secrets = {
      "miniflux-credentialsfile" = {};
    };
  };

  environment.systemPackages = with pkgs; [
    miniflux
  ];

  networking.firewall = {
    allowedTCPPorts = [port];
  };

  services.miniflux = {
    enable = true;
    # openFirewall = true;
    adminCredentialsFile = "${config.sops.secrets."miniflux-credentialsfile".path}";

    config = {
      LISTEN_ADDR = "127.0.0.1:${toString port}";
      # BASE_URL = "https://${baseDomain}";
      BASE_URL = "https://${subDomain}.${baseDomain}";
      CREATE_ADMIN = "1";
    };
  };

  homelab.services.miniflux = {
    homepage = {
      name = "Miniflux";
      description = "";
      icon = "miniflux.svg";
      category = "Media";
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
