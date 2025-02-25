{
  description = "NixOS and Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    hosts = [
      {
        name = "framework";
        monitors = [
          {
            name = "eDP-1";
            dimensions = "2256x1504";
            position = "0x0";
            scale = 1.175;
            internal = true;
            framerate = 60;
            transform = 0;
          }
        ];
      }
      {
        name = "chimaera";
        monitors = [
          {
            name = "DP-3";
            dimensions = "1920x1080";
            position = "0x0";
            scale = 1;
            framerate = 144;
            transform = 0;
          }
        ];
      }
    ];
  in {
    nixosConfigurations = builtins.listToAttrs (map (host: {
        name = host.name;
        value = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./configuration.nix
            ./machines/${host.name}/hardware-configuration.nix
          ];
          specialArgs = {
            meta = {
              hostname = host.name;
              monitors = host.monitors or [];
            };
            inputs = self.inputs;
            outputs = self.outputs;
          };
        };
      })
      hosts);
    homeConfigurations = {
      max = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
        ];
      };
    };
    # homeConfigurations = builtins.listToAttrs (map (host: {
    #        # name = "max"; #  Home Manager username
    # name = user.name;
    #        value = home-manager.lib.homeManagerConfiguration {
    #          inherit pkgs;
    #          modules = [
    #            ./home.nix
    #          ];
    #          specialArgs = {
    #            meta = {
    #              hostname = host.name; # Pass the host's name
    #              monitors = host.monitors or []; # Pass the host's monitors
    #            };
    #            inputs = self.inputs;
    #            outputs = self.outputs;
    #          };
    #        };
    #      }) hosts);
    #    };
    # };

    # nixosConfigurations = builtins.listToAttrs (map (host: {
    #         name = host.name;
    #         value = nixpkgs.lib.nixosSystem {
    #           specialArgs = {
    #             # inherit inputs outputs;
    # 	    inputs = self.inputs;
    # 	    outputs = self.outputs;
    #             meta = {
    #               hostname = host.name;
    #             };
    #           };
    #           system = "x86_64-linux";
    #           modules =
    #             [
    #               # Modules
    #               # disko.nixosModules.disko
    #               # System Specific
    #               ./machines/${host.name}/hardware-configuration.nix
    #               # General
    #               ./configuration.nix
    #               # Home Manager
    #               home-manager.nixosModules.home-manager
    #               {
    #                 home-manager.useGlobalPkgs = true;
    #                 home-manager.useUserPackages = true;
    #                 home-manager.users.max = import ./home.nix;
    #                 home-manager.extraSpecialArgs = {
    #                   # inherit inputs;
    #                   meta = host;
    #                 };
    #               }
    #             ];
    #             # ++ (
    #             #   if host.hardware != null
    #             #   then [host.hardware]
    #             #   else []
    #             # );
    #         };
    #       })
    #       hosts);
  };
}
