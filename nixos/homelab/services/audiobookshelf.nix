{
  pkgs,
  config,
  ...
}: let
  baseDomain = "yumo4.dev";
  subDomain = "audiobooks";
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
    dataDir = "audiobookshelf";
  };

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
  };
}
