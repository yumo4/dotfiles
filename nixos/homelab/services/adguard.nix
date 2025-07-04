{
  pkgs,
  config,
  inputs,
  ...
}: let
  baseDomain = "yumo4.duckdns.org";
  subDomain = "ad";
  localDomain = "homeone";
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
    # templates = {
    #   "adguard-admin-password" = {
    #     content = ''
    #       ${config.sops.placeholder."adguard-password"}
    #     '';
    #     owner = "adguardhome";
    #     group = "adguardhome";
    #   };
    # };
    # templates = {
    #   "adguard-admin-password".content = ''
    #     ${config.sops.placeholder.adguard-password}
    #   '';
    # };
    # templates = {
    #   "adguard-config" = {
    #     # content = "${config.sops.placeholder."adguard-password"}";
    #     content = builtins.toJSON {
    #       users = [
    #         {
    #           name = "admin";
    #           password = config.sops.placeholder."adguard-password";
    #         }
    #       ];
    #     };
    #     path = "/var/lib/AdGuardHome/users.json";
    #   };
    # };
  };
  environment.systemPackages = with pkgs; [
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
        upstream_dns = [
          # "192.168.178.1"
          # "1.1.1.1"
          # "8.8.8.8"
          "https://dns.quad9.net/dns-query"
          # "https://dns.google.com/dns-query"
          "https://dns.cloudflare.com/dns-query"
          # "https://dns10.quad9.net/dns-query"
        ];
        rewrites = [
          {
            domain = "${baseDomain}";
            answer = serverIP;
          }

          {
            domain = "*.${baseDomain}";
            answer = serverIP;
          }

          {
            domain = "${localDomain}";
            answer = serverIP;
          }

          {
            domain = "*.${localDomain}";
            answer = serverIP;
          }
        ];

        enable_dnssec = true;
      };
      filtering = {
        protection_enabled = true;
        filtering_enabled = true;
      };
      # users = [
      #   {
      #     name = "admin";
      #     password = config.sops.secrets."adguard-password";
      #     # password = "${config.sops.templates."adguard-admin-password".path}";
      #     # password = "${config.sops.secrets."adguard-password".path}";
      #     # password = "$2y$05$FaUu9KYphHFEEKFX3fwsBuKAv/XYTCk3P1l3fBEXVMuO3t8NXatV6";
      #   }
      # ];
      filters =
        map (url: {
          enabled = true;
          url = url;
        }) [
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_9.txt" # The Big List of Hacked Malware Web Sites
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_11.txt" # malicious url blocklist
          "https://adguardteam.github.io/HostlistsRegistry/assets/filter_1.txt" # default dns filter
          "https://adaway.org/hosts.txt" # default ad block list
        ];
    };
  };

  homelab.services.adguard-home = {
    homepage = {
      name = "Adguard";
      description = "";
      icon = "adguard-home.svg";
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
