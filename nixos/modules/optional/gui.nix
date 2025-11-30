{
  pkgs,
  lib,
  inputs,
  meta,
  ...
}: let
  system = pkgs.stdenv.hostPlatform.system;
in {
  imports = [inputs.niri.nixosModules.niri];

  services.displayManager.ly.enable = true;
  services.desktopManager.gnome.enable = true;
  # services.xserver.windowManager.qtile.enable = true;
  # programs.hyprland.enable = true;
  programs.niri.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];
    config = {
      common = {
        default = ["gnome" "gtk"];
        "org.freedesktop.impl.portal.ScreenCast" = ["gnome"];
        "org.freedesktop.impl.portal.Screenshot" = ["gnome"];
      };
    };
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    XDG_CURRENT_DESKTOP = "GNOME"; # Pretend to be GNOME
    XDG_SESSION_TYPE = "wayland";
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
    # videoDrivers = ["modesetting" "amdgpu" "nvidia"]; # intel amd nvidia
    videoDrivers =
      if meta.hostname == "chimaera"
      then ["amdgpu"]
      else if meta.hostname == "lusankya"
      then ["modesetting nvidia"]
      else ["modesetting"];
  };
  hardware = lib.optionalAttrs (meta.hostname == "lusankya") {
    nvidia.open = true;
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "altgr-intl";
  };

  # enables touchpads
  services.libinput.enable = true;

  environment.systemPackages = with pkgs; [
    # networkmanagerapplet
    # obs-studio
    # syshud
    # vesktop
    # vlc
    # zed-editor
    alacritty
    alsa-utils
    blueman
    ghostty
    gtk3
    helium-browser
    hyprlock
    hyprpicker
    hyprshot
    inputs.zen-browser.packages."${system}".default
    libnotify
    nautilus
    niri
    obsidian
    playerctl
    rofi
    swaynotificationcenter
    swww
    tailscale-systray
    unzip
    vscodium-fhs
    waybar
    wl-clipboard
    xwayland-satellite
  ];
}
