{
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [inputs.niri.nixosModules.niri];

  services.displayManager.ly.enable = true;
  services.desktopManager.gnome.enable = true;
  # services.xserver.windowManager.qtile.enable = true;
  programs.hyprland.enable = true;
  programs.niri.enable = true;
  # programs.niri.package = inputs.niri.packages.${pkgs.system}.niri;

  xdg.portal = {
    enable = true;
    extraPortals = lib.mkForce [
      pkgs.xdg-desktop-portal-gtk # For both
      pkgs.xdg-desktop-portal-hyprland # For Hyprland
      pkgs.xdg-desktop-portal-gnome # For GNOME
      pkgs.xdg-desktop-portal-wlr # For Niri
    ];
  };

  # services.blueman.enable = true;
  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    enableTearFree = true;
    videoDrivers = ["modesetting" "amdgpu"]; # intel amd
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "altgr-intl";
  };

  # enables touchpads
  services.libinput.enable = true;

  environment.systemPackages = with pkgs; [
    blueman
    brave
    # orca-slicer
    alsa-utils
    ghostty
    gnome-control-center
    gtk3
    hyprlock
    hyprshot
    hyprpicker
    inputs.zen-browser.packages."${system}".default
    niri
    libnotify
    nautilus
    networkmanagerapplet
    obs-studio
    obsidian
    playerctl
    pika-backup
    rofi-wayland
    swaynotificationcenter
    swww
    tailscale-systray
    unzip
    vesktop
    vlc
    vscodium-fhs
    waybar
    wl-clipboard
  ];
}
