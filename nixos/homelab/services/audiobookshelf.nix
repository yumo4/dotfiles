{
  pkgs,
  config,
  ...
}: let
  baseDomain = "yumo4.duckdns.org";
  subDomain = "audiobooks";
  localDomain = "homeone";
  port = 8000;
in {
  environment.systemPackages = with pkgs; [
    audiobookshelf
  ];

  services.audiobookshelf = {
    enable = true;
    openFirewall = true;
    port = port;
    host = "127.0.0.1";
    # dataDir = "/var/lib/audiobookshelf";
    dataDir = "audiobookshelf";
    # user = "max";
    # group = "audiobookshelf";
  };

  # users.users.audiobookshelf = {
  #   extraGroups = ["users"];
  # };

  fileSystems."/var/lib/audiobookshelf/audiobooks" = {
    device = "/home/max/Media/Audiobooks";
    options = ["bind"];
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/audiobookshelf 0755 audiobookshelf audiobookshelf -"
    #   "d /var/lib/audiobookshelf/audiobooks 0755 audiobookshelf users -"
  ];

  homelab.services.audiobookshelf = {
    homepage = {
      name = "Audiobookshelf";
      description = "";
      icon = "audiobookshelf.svg";
      category = "Media";
    };
    url = "${subDomain}.${baseDomain}";
  };

  services.caddy = {
    virtualHosts."${subDomain}.${baseDomain}" = {
      useACMEHost = baseDomain;

      extraConfig = ''
        reverse_proxy http://127.0.0.1:${toString port}
      '';
    };

    virtualHosts."${subDomain}.${localDomain}" = {
      extraConfig = ''
        reverse_proxy http://127.0.0.1:${toString port}
      '';
    };
  };
}
