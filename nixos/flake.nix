{
  description = "NixOS and Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # this makes picking both unstable and stable packages possible
    # unstable is the default
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mysecrets = {
      url = "git+ssh://git@github.com/yumo4/nix-secrets.git?ref=main&shallow=1";
      flake = false;
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sherlock = {
      url = "github:Skxxtz/sherlock";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    overlays = [
      (final: prev: {
        helium-browser = prev.callPackage ./packages/helium/default.nix {};
      })
    ];
    # pkgs = nixpkgs.legacyPackages.${system};
    pkgs = nixpkgs.legacyPackages.${system}.extend (nixpkgs.lib.composeManyExtensions overlays);
    pkgs-stable = nixpkgs-stable.legacyPackages.${system};
    username = "max";
    hosts = [
      {
        name = "framework";
        isServer = false;
        isWork = false;
      }
      {
        name = "chimaera";
        isServer = false;
        isWork = false;
      }
      {
        name = "homeone";
        isServer = true;
        isWork = false;
      }
      {
        name = "lusankya";
        isServer = false;
        isWork = true;
      }
    ];
  in {
    packages.${system}.helium-browser = pkgs.helium-browser;

    nixosConfigurations = builtins.listToAttrs (map (host: {
        name = host.name;
        value = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            {nixpkgs.overlays = overlays;}
            ./machines/${host.name}/configuration.nix
            ./machines/${host.name}/hardware-configuration.nix
          ];
          specialArgs = {
            inherit inputs;
            inherit pkgs-stable;
            inherit overlays;
            meta = {
              hostname = host.name;
              isServer = host.isServer;
              isWork = host.isWork;
            };
          };
        };
      })
      hosts);

    homeConfigurations = builtins.listToAttrs (map (host: {
        name = "${username}@${host.name}";
        value = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit inputs;
            inherit pkgs-stable;
            meta = {
              hostname = host.name;
              isServer = host.isServer;
              isWork = host.isWork;
            };
          };
          modules = [
            ./machines/${host.name}/home.nix
          ];
        };
      })
      hosts);
  };
}
