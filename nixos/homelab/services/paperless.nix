{
  pkgs,
  config,
  inputs,
  ...
}: let
  baseDomain = "yumo4.dev";
  subDomain = "paperless";
  port = 18981;
  secretspath = builtins.toString inputs.mysecrets;
in {
  imports = [inputs.sops-nix.nixosModules.sops];
  sops = {
    defaultSopsFile = "${secretspath}/secrets.yaml";
    validateSopsFiles = false;

    secrets = {
      "paperless-admin-password" = {};
    };
  };
  environment.systemPackages = with pkgs; [
    paperless-ngx
  ];

  networking.firewall = {
    allowedTCPPorts = [port];
  };
  services.paperless = {
    enable = true;
    passwordFile = config.sops.secrets."paperless-admin-password".path;
    address = "127.0.0.1";
    port = port;

    dataDir = "/var/lib/paperless";
    mediaDir = "/var/lib/paperless/media";
    consumptionDir = "/var/lib/paperless/consume";
    consumptionDirIsPublic = true;

    settings = {
      PAPERLESS_CONSUMER_IGNORE_PATTERN = [
        ".DS_STORE/*"
        "desktop.ini"
      ];
      PAPERLESS_OCR_LANGUAGE = "deu+eng";
      PAPERLESS_OCR_USER_ARGS = {
        optimize = 1;
        pdfa_image_compression = "lossless";
      };

      PAPERLESS_CSRF_TRUSTED_ORIGINS = "https://${subDomain}.${baseDomain}";
      PAPERLESS_ALLOWED_HOSTS = "${subDomain}.${baseDomain}, 127.0.0.1, localhost";
    };
  };

  homelab.services.paperless = {
    homepage = {
      name = "Paperless";
      description = "";
      icon = "paperless.svg";
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
