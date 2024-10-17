{
  description = "NixOS and Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }: 
    let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    hosts = [
      {
        name = "framework";
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
            };
            inputs = self.inputs;
            outputs = self.outputs;
          };
        };
      }) hosts);
    homeConfigurations = {
      max = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
        ];
      };
    };
  };
}
