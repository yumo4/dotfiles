# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, meta, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./machines/${meta.hostname}/hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = meta.hostname;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    enableTearFree = true;
    videoDrivers = ["intel" "amdgpu"];
  };

  # services.xserver.displayManager.gdm.enable = true;
  services.displayManager.ly.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  # services.xserver.windowManager.qtile.enable = true;
  programs.hyprland.enable = true;

 # xdg.portal = {
 #    enable = true;
 #    extraPortals = lib.mkForce [
 #      pkgs.xdg-desktop-portal-gtk # For both
 #    ];
 #  };


  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "altgr-intl";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # services.blueman.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
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

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes"];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.max = {
    isNormalUser = true;
    description = "max";
    extraGroups = [ "networkmanager" "video" "wheel" "docker" "uinput"];
    shell = pkgs.zsh;
    packages = with pkgs; [
   	tree
	lsd
	fastfetch
    ];
  };

  programs.firefox.enable = true;
  programs.fish.enable = true;
  programs.zsh.enable = true;
  hardware.brillo.enable = true;
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", MODE="0666"
  '';

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    alacritty
    alejandra
    alsa-utils
    bambu-studio
    blueman
    brave
    btop
    calibre
    dunst
    fd
    fish
    flameshot
    fzf
    gammastep
    gcc
    git
    go
    go-migrate
    gofumpt
    goimports-reviser
    golines
    gopls
    gtk3
    hyprshot
    jetbrains-mono
    kanata
    lua
    lua-language-server
    luajitPackages.luarocks
    neovim
    nerd-fonts.jetbrains-mono
    networkmanagerapplet
    nitrogen
    nixd
    nodejs_22
    obsidian
    oh-my-posh
    pcmanfm
    pika-backup
    playerctl
    python3
    racket
    redshift
    ripgrep
    rofi
    rofi-wayland
    stow
    stylua
    swww
    syncthing
    tailwindcss
    tmux
    unzip
    vesktop
    vlc
    waybar
    wget
    xclip
    zip
    zoom-us
    zoxide
    zulu # java
  ];

  services.kanata = {
      enable = true;
      keyboards = {
	internalKeyboard = {
	  devices = [
	    "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
	  ];
	  extraDefCfg = "process-unmapped-keys yes";
	  config = ''
	    (defsrc
	     caps a s d f j k l ;
	    )
	    (defvar
	     tap-time 150
	     hold-time 200
	    )
	    (defalias
	     caps (tap-hold 100 100 esc lctl)
	     a (tap-hold $tap-time $hold-time a lmet)
	     s (tap-hold $tap-time $hold-time s lalt)
	     d (tap-hold $tap-time $hold-time d lsft)
	     f (tap-hold $tap-time $hold-time f lctl)
	     j (tap-hold $tap-time $hold-time j rctl)
	     k (tap-hold $tap-time $hold-time k rsft)
	     l (tap-hold $tap-time $hold-time l ralt)
	     ; (tap-hold $tap-time $hold-time ; rmet)
	    )

	    (deflayer base
	     @caps @a  @s  @d  @f  @j  @k  @l  @;
	    )
	  '';
	};
      };
    };
# Optimization & Garbage Collection

  # Optimize Nix-Store During Rebuilds
  # NOTE: Optimizes during builds - results in slower builds
  nix.settings.auto-optimise-store = true;

  # Purge Unused Nix-Store Entries
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true; programs.gnupg.agent = { enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "24.05";
}
