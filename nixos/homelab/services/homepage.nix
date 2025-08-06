{
  pkgs,
  config,
  lib,
  ...
}: let
  serverIP = "192.168.178.65";
  baseDomain = "yumo4.dev";
  subDomain = "home";
  port = 8082;

  homepageServices =
    lib.filterAttrs (
      name: service:
        service ? homepage
    )
    config.homelab.services;

  servicesByCategory =
    lib.groupBy (service: service.homepage.category)
    (lib.attrValues homepageServices);

  generateHomepageServices = category: services:
    lib.map (service: {
      "${service.homepage.name}" = {
        icon = service.homepage.icon;
        description = service.homepage.description;
        href = "https://${service.url}";
        siteMonitor = "https://${service.url}";
      };
    })
    services;
in {
  options.homelab.services = lib.mkOption {
    type = lib.types.attrsOf (lib.types.submodule {
      options = {
        homepage = lib.mkOption {
          type = lib.types.nullOr (lib.types.submodule {
            options = {
              name = lib.mkOption {
                type = lib.types.str;
                description = "Display name for homepage";
              };
              description = lib.mkOption {
                type = lib.types.str;
                description = "Service description";
              };
              icon = lib.mkOption {
                type = lib.types.str;
                description = "Icon filename";
              };
              category = lib.mkOption {
                type = lib.types.str;
                description = "Category for grouping";
              };
            };
          });
          description = "Homepage configuration for this service";
          default = null;
        };
        url = lib.mkOption {
          type = lib.types.str;
          description = "Service URL";
        };
      };
    });
    default = {};
  };

  config = {
    environment.systemPackages = with pkgs; [
      glances
      homepage-dashboard
    ];

    services.glances = {
      enable = true;
      openFirewall = true;
    };

    services.homepage-dashboard = {
      enable = true;
      openFirewall = true;
      # allowedHosts = "localhost:${toString port},127.0.0.1:${toString port},${subDomain}.${baseDomain}";
      allowedHosts = "localhost:${toString port},127.0.0.1:${toString port},${serverIP}:${toString port},${subDomain}.${baseDomain}";
      customCSS = ''
        body, html {
         font-family: SF Pro Display, Helvetica, Arial, sans-serif !important;
        }
        .font-medium {
         font-weight: 700 !important;
        }
        .font-light {
         font-weight: 500 !important;
        }
        .font-thin {
         font-weight: 400 !important;
        }
        #information-widets {
         padding-left: 1.5rem;
         padding-right: 1.5rem;
        }
        div#footer {
         display: none;
        }
        .services-group.basis hfull.flex-1.px-1.-my-1 {
         padding-bottom: 3em;
        }
      '';
      # services.glances.enable = true;
      settings = {
        layout =
          [
            {
              Glances = {
                header = false;
                style = "row";
                columns = 4;
              };
            }
          ]
          ++ (lib.mapAttrsToList (category: services: {
              "${category}" = {
                header = true;
                style = "column";
              };
            })
            servicesByCategory);

        headerStyle = "clean";
        statusStyle = "dot";
        hideVersion = true;
      };
      services =
        [
          {
            Glances = let
              glancesPort = toString config.services.glances.port;
            in [
              {
                Info = {
                  widget = {
                    type = "glances";
                    url = "http://localhost:${glancesPort}";
                    metric = "info";
                    chart = true;
                    # chart = false;
                    version = 4;
                  };
                };
              }
              {
                "CPU Temp" = {
                  widget = {
                    type = "glances";
                    url = "http://localhost:${glancesPort}";
                    metric = "sensor:Package id 0";
                    # chart = false;
                    chart = true;
                    version = 4;
                  };
                };
              }
              {
                "Disk" = {
                  widget = {
                    type = "glances";
                    url = "http://localhost:${glancesPort}";
                    metric = "fs:/";
                    chart = true;
                    version = 4;
                  };
                };
              }
              {
                "External Disk" = {
                  widget = {
                    type = "glances";
                    url = "http://localhost:${glancesPort}";
                    metric = "fs:/mnt/nebulon-b-01";
                    chart = true;
                    version = 4;
                  };
                };
              }
            ];
          }
        ]
        ++ (lib.mapAttrsToList (category: services: {
            "${category}" = generateHomepageServices category services;
          })
          servicesByCategory);
    };

    services.caddy = {
      virtualHosts."${subDomain}.${baseDomain}" = {
        useACMEHost = baseDomain;

        extraConfig = ''
          reverse_proxy http://127.0.0.1:${toString port}
        '';
      };
    };
  };
}
