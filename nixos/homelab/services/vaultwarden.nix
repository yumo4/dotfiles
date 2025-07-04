{
  pkgs,
  config,
  inputs,
  lib,
  ...
}: let
  baseDomain = "yumo4.duckdns.org";
  subDomain = "vaultwarden";
  port = 9090;
  smtpPort = 465;
  secretspath = builtins.toString inputs.mysecrets;
in {
  imports = [inputs.sops-nix.nixosModules.sops];
  sops = {
    defaultSopsFile = "${secretspath}/secrets.yaml";
    validateSopsFiles = false;

    secrets = {
      "vaultwarden-env" = {};
    };
  };

  networking.firewall = {
    allowedTCPPorts = [port];
  };

  environment.systemPackages = with pkgs; [
    vaultwarden
    libargon2
    openssl
  ];

  services.vaultwarden = {
    enable = true;

    # NOTE: db location in `/var/lib/bitwarden_rs/`

    # backupDir = "/var/lib/vaultwarden/backup";

    config = {
      ROCKET_ADDRESS = "127.0.0.1";
      ROCKET_PORT = port;
      DOMAIN = "https://${subDomain}.${baseDomain}";

      SIGNUPS_ALLOWED = false;
      INVITATIONS_ALLOWED = true;
      INVITATION_ORG_NAME = "home-one-vault";

      WEB_VAULT_ENABLED = true;
      WEBSOCKET_ENABLED = true;

      SMTP_HOST = "smtp.gmail.com";
      SMTP_FROM = "maximilian.troe@gmail.com";
      SMTP_FROM_NAME = "Vaultwarden";
      SMTP_PORT = smtpPort;
      SMTP_SECURITY = "force_tls";
    };

    # admin_token, smtp_password, smtp_username
    environmentFile = "${config.sops.secrets."vaultwarden-env".path}";
  };

  homelab.services.vaultwarden = {
    homepage = {
      name = "Vaultwarden";
      description = "";
      icon = "bitwarden.svg";
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
