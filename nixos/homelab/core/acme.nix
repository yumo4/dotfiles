{
  pkgs,
  config,
  inputs,
  ...
}: let
  baseDomain = "yumo4.duckdns.org";
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

    certs."${baseDomain}" = {
      group = config.services.caddy.group;

      domain = "${baseDomain}";
      extraDomainNames = ["*.${baseDomain}"];
      dnsProvider = "duckdns";
      dnsResolver = "1.1.1.1:53";
      dnsPropagationCheck = true;

      webroot = null;

      reloadServices = ["caddy.service"];
      environmentFile = "${config.sops.secrets."duckdns-env".path}";
    };
  };
}
