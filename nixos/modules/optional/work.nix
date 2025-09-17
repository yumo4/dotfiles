{
  pkgs,
  lib,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # bruno
    # openfortivpn-webview # gtk
    gnome-control-center # gnome settings application
    gnome-network-displays # might be buggy
    jetbrains.phpstorm
    keepassxc
    make
    nextcloud-client
    openfortivpn
    teams-for-linux
  ];
}
