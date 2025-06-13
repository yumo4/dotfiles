{
  config,
  lib,
  inputs,
  ...
}: let
  hl = config.homelab;
  secretspath = builtins.toString inputs.mysecrets;
  baseDomain = "yumo4.duckdns.org";
in {
  sops.secrets."duckdns-env" = {
    group = config.services.caddy.group;
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
  security.acme = {
    acceptTerms = true;
    defaults.email = "maximilian.troe@gmail.com";
    certs.${baseDomain} = {
      reloadServices = ["caddy.service"];
      domain = "${baseDomain}";
      extraDomainNames = ["*.${baseDomain}"];
      dnsProvider = "duckdns";
      dnsResolver = "1.1.1.1:53";
      dnsPropagationCheck = true;
      group = config.services.caddy.group;

      # TODO: Credentials
      # environmentFile = config.homelab.cloudflare.dnsCredentialsFile;
      # environmentFile = lib.mkIf (config.sops.secrets ? "acme-duckdns-credentials") config.sops.secrets."acme-duckdns-credentials".path;

      # idk if thats the way?
      environmentFile = config.sops.secrets."duckdns-env".path;

      # environmentFile = config.homelab.duckdns.dnsCredentialsFile;
      # environmentFile = "cat ${config.sops.secrets."duckdns-env".path}";
    };
  };
  services.caddy = {
    enable = true;
    globalConfig = ''
      auto_https off
    '';
    # NOTE: what does this do?
    virtualHosts = {
      "http://${baseDomain}" = {
        extraConfig = ''
          redir https://{host}{uri}
        '';
      };
      "http://*.${baseDomain}" = {
        extraConfig = ''
          redir https://{host}{uri}
        '';
      };
    };
  };
  # NOTE: this enables podman (docker drop in replacement)
  # virtualisation.podman = {
  #   dockerCompat = true;
  #   autoPrune.enable = true;
  #   extraPackages = [pkgs.zfs];
  #   defaultNetwork.settings = {
  #     dns_enabled = true;
  #   };
  # };
  # virtualisation.oci-containers = {
  #   backend = "podman";
  # };

  # networking.firewall.interfaces.podman0.allowedUDPPorts =
  #   lib.lists.optionals config.virtualisation.podman.enable
  #   [53];

  imports = [
    ./homepage.nix

    inputs.sops-nix.nixosModules.sops
    # ../../../modules/core/sops.nix
  ];
}
