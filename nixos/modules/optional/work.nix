{
  pkgs,
  lib,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # bruno
    # openfortivpn-webview # gtk
    php84Packages.composer
    gnome-control-center # gnome settings application
    gnome-network-displays # might be buggy
    jetbrains.phpstorm
    keepassxc
    gnumake
    mysql_jdbc
    nextcloud-client
    openfortivpn
    firefoxpwa
    libreoffice-fresh
    # (pkgs.writeShellScriptBin "teams-for-linux-wayland" ''
    #   export XDG_CURRENT_DESKTOP=sway
    #   exec ${pkgs.teams-for-linux}/bin/teams-for-linux --enable-features=WebRTCPipeWireCapturer "$@"
    # '')
    teams-for-linux
    # (wrapOBS {
    #   plugins = with pkgs.obs-studio-plugins; [
    #     wlrobs
    #     obs-backgroundremoval
    #     obs-pipewire-audio-capture
    #     obs-gstreamer
    #     obs-vaapi
    #   ];
    # })
  ];
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    nativeMessagingHosts.packages = [pkgs.firefoxpwa];
  };

  programs.obs-studio = {
    enable = true;
    enableVirtualCamera = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-gstreamer
      obs-vaapi
    ];
  };
  boot.extraModulePackages = with pkgs.linuxPackages; [v4l2loopback];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';
  boot.kernelModules = ["v4l2loopback"];
}
