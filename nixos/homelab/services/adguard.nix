{
  pkgs,
  config,
  inputs,
  ...
}: let
  baseDomain = "yumo4.dev";
  subDomain = "ad";
  serverIP = "192.168.178.65";
  port = 3000;
  dnsPort = 53;

  secretspath = builtins.toString inputs.mysecrets;
in {
  imports = [inputs.sops-nix.nixosModules.sops];
  sops = {
    defaultSopsFile = "${secretspath}/secrets.yaml";
    validateSopsFiles = false;

    secrets = {
      "adguard-password" = {};
    };
  };
  environment.systemPackages = with pkgs; [
    adguardhome
    # inetutils
    # dnsutils
  ];

  networking.firewall = {
    allowedTCPPorts = [port dnsPort];
    allowedUDPPorts = [dnsPort];
  };

  services.adguardhome = {
    enable = true;
    openFirewall = false;
    host = "0.0.0.0";
    port = port;
    mutableSettings = true;
    settings = {
      schema_version = config.services.adguardhome.package.schema_version;
      http = {
        address = "0.0.0.0:${toString port}";
        # address = "127.0.0.1:${toString port}";
      };
      dns = {
        bind_hosts = ["0.0.0.0"];
        port = dnsPort;
        bootstrap_dns = [
          "1.1.1.1"
          "8.8.8.8"
        ];
        upstream_dns = [
          "https://dns.quad9.net/dns-query"
          # "https://dns.google.com/dns-query"
          # "https://dns.cloudflare.com/dns-query"
          "https://dns10.quad9.net/dns-query"
        ];
        enable_dnssec = true;
        rewrites = [
          {
            domain = "${baseDomain}";
            answer = serverIP;
          }

          {
            domain = "*.${baseDomain}";
            answer = serverIP;
          }
        ];
      };
      filtering = {
        protection_enabled = true;
        filtering_enabled = true;
      };
      # users = [
      #   {
      #     name = "admin";
      #     password = "";
      #   }
      # ];
      filters = [
        {
          name = "AdGuard DNS filter";
          url = "https://adguardteam.github.io/AdGuardSDNSFilter/Filters/filter.txt";
          enabled = true;
        }
        {
          name = "AdAway Default Blocklist";
          url = "https://adaway.org/hosts.txt";
          enabled = true;
        }
      ];
      # "https://adguardteam.github.io/HostlistsRegistry/assets/filter_9.txt" # The Big List of Hacked Malware Web Sites
      # "https://adguardteam.github.io/HostlistsRegistry/assets/filter_11.txt" # malicious url blocklist
      # "https://adguardteam.github.io/HostlistsRegistry/assets/filter_1.txt" # default dns filter
    };
  };

  homelab.services.adguard-home = {
    homepage = {
      name = "Adguard";
      description = "";
      icon = "adguard-home.svg";
      category = "Network";
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
