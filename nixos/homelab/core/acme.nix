{
  pkgs,
  config,
  inputs,
  ...
}: let
  domain = "yumo4.duckdns.org";
  domainEmail = "maximilian.troe@gmail.com";
  secretspath = builtins.toString inputs.mysecrets;
in {
  imports = [inputs.sops-nix.nixosModules.sops];
  sops = {
    defaultSopsFile = "${secretspath}/secrets.yaml";
    validateSopsFiles = false;

    secrets = {
      "duckdns-env" = {};
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "${domainEmail}";

    certs."${domain}" = {
      group = config.services.caddy.group;

      domain = "${domain}";
      extraDomainNames = ["*.${domain}"];
      dnsProvider = "duckdns";
      dnsResolver = "1.1.1.1:53";
      dnsPropagationCheck = true;
      environmentFile = "${config.sops.secrets."duckdns-env".path}";
    };
  };
}
