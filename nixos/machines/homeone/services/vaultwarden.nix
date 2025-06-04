# NOTE: THIS IS AN EXAMPLE FILE
{
  pkgs,
  config,
  ...
}: let
  settings = import ../../settings.nix;
in {
  age.secrets.vaultwarden.file = ../../secrets/server/vaultwarden.age;

  services.vaultwarden = {
    enable = true;
    package = pkgs.vaultwarden-postgresql;
    dbBackend = "postgresql";
    environmentFile = config.age.secrets.vaultwarden.path;
    config = {
      DOMAIN = "https://${settings.server.vaultwarden.domain}";
      ROCKET_ADDRESS = "127.0.0.1";
      ROCKET_PORT = 8000;
      SIGNUPS_ALLOWED = settings.server.vaultwarden.signups_allowed;
      SIGNUPS_VERIFY = settings.server.vaultwarden.signups_verfiy;
      SENDS_ALLOWED = settings.server.vaultwarden.sends_allowed;
      SMTP_HOST = settings.mail.host;
      SMTP_FROM = settings.server.vaultwarden.mail.from.address;
      SMTP_FROM_NAME = settings.server.vaultwarden.mail.from.name;
      SMTP_SECURITY = settings.mail.security;
      SMTP_PORT = settings.mail.port;
      SMTP_USERNAME = settings.mail.username;
      SMTP_PASSWORD = settings.mail.password;
    };
  };

  services.nginx.virtualHosts.${settings.server.vaultwarden.domain} = {
    enableACME = true;
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://localhost:${toString config.services.vaultwarden.config.ROCKET_PORT}";
      proxyWebsockets = true;
    };
  };
}
