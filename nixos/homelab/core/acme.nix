{
  pkgs,
  config,
  inputs,
  ...
}: let
  baseDomain = "yumo4.dev";
  domainEmail = "maximilian.troe@gmail.com";
  secretspath = builtins.toString inputs.mysecrets;
in {
  imports = [inputs.sops-nix.nixosModules.sops];
  sops = {
    defaultSopsFile = "${secretspath}/secrets.yaml";
    validateSopsFiles = false;

    secrets = {
      "cloudflare-env" = {};
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "${domainEmail}";

    certs."${baseDomain}" = {
      group = config.services.caddy.group;

      domain = "${baseDomain}";
      extraDomainNames = ["*.${baseDomain}"];
      dnsProvider = "cloudflare";
      dnsResolver = "1.1.1.1:53";
      dnsPropagationCheck = true;

      webroot = null;

      reloadServices = ["caddy.service"];
      environmentFile = "${config.sops.secrets."cloudflare-env".path}";
    };
  };
}
