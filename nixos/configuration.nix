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
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  services.displayManager.ly.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.windowManager.qtile.enable = true;
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
    variant = "";
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
  services.xserver.libinput.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes"];

  fonts.packages = with pkgs; [ (nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) ];


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

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # networkmanager
    # typescript-language-server
    alacritty
    alejandra
    alsa-utils
    blueman
    brave
    brillo
    btop
    # calibre
    dunst
    fish
    flameshot
    fzf
    gcc
    swww
    git
    go
    go-migrate
    gofumpt
    goimports-reviser
    golines
    gopls
    gtk3
    kanata
    lua-language-server
    neovim
    networkmanagerapplet
    nitrogen
    nodejs_22
    obsidian
    oh-my-posh
    pcmanfm
    xfce.thunar
    pika-backup
    vlc
    playerctl
    # python312Packages.iwlib # qtile wlan widget fix?
    # iw # qtile wlan widget fix?
    # wirelesstools # qtile wlan widget fix?
    racket
    redshift
    gammastep
    ripgrep
    rofi
    rofi-wayland
    # starship
    stow
    stylua
    syncthing
    tailwindcss
    tmux
    unzip
    vesktop
    waybar
    xclip
    zip
    zoom-us
    zoxide
  #  wget
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
	     caps
	    )
	    (defalias
	     caps (tap-hold 100 100 esc lctl)
	    )
	    (deflayer base
	     @caps
	    )
	  '';
	};
      };
    };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
