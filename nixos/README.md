# Nixos
### structure
This is a flake based Nixos configuration.

**machines**: each machine (host) consists of a `configuration.nix`, `home.nix` and `hardware-configuration.nix` files
    - chimaera: desktop, main machine
    - framework: laptop, personal 
    - homeone: home server
**modules**: system level configurations devided into `core` and `optional`
**home**: home level (home-manager) configurations devided into `core` and `optional`
**homelab**: "preconfigurations" for servers devided into `services` (similar to modules & home)

