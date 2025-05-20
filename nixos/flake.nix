{
  description = "NixOS and Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # this makes picking both unstable and stable packages possible
    # unstable is the default
    # for installing a stable package use `stable.<packagename>`
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    username = "max";
    hosts = [
      {
        name = "framework";
      }
      {
        name = "chimaera";
      }
    ];
  in {
    nixosConfigurations = builtins.listToAttrs (map (host: {
        name = host.name;
        value = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./machines/${host.name}/configuration.nix
            ./machines/${host.name}/hardware-configuration.nix
          ];
          specialArgs = {
            inherit inputs;
            meta = {
              hostname = host.name;
              # monitors = host.monitors or [];
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
            meta = {hostname = host.name;};
          };
          modules = [
            # Common home configuration files
            # ./home.nix
            # Machine-specific home configuration if it exists
            ./machines/${host.name}/home.nix
          ];
        };
      })
      hosts);
  };
}
