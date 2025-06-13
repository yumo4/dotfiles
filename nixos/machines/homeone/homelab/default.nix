{
  config,
  lib,
  inputs,
  ...
}: let
  hl = config.homelab;
  # secretspath = builtins.toString inputs.mysecrets;
in {
  # sops = {
  #   # age.keyFile = "/home/max/.config/sops/age/keys.txt";
  #   defaultSopsFile = "${secretspath}/secrets.yaml";
  #   validateSopsFiles = false;
  #
  #   secrets = {
  #     duckdns-env = {
  #       owner = config.users.users.max.name;
  #       inherit (config.users.users.max) group;
  #     };
  #   };
  # };

  homelab = {
    enable = true;
    baseDomain = "yumo4.duckdns.org";
    # duckdns.dnsCredentialsFile = config.sops.secrets.duckdns-env.path;
    # duckdns.dnsCredentialsFile = "";
    # duckdns.dnsCredentialsFile = "cat ${config.sops.secrets."duckdns-env".path}";
    # duckdns.dnsCredentialsFile = "cat ${config.sops.secrets."duckdns-token".path}";
    timeZone = "Europe/Berlin";
    # mounts = {
    #   config = "/persist/opt/services";
    #   slow = "/mnt/mergerfs_slow";
    #   fast = "/mnt/cache";
    #   merged = "/mnt/user";
    # };
    # samba = {
    #   enable = true;
    #   passwordFile = config.age.secrets.sambaPassword.path;
    #   shares = {
    #     Backups = {
    #       path = "${hl.mounts.merged}/Backups";
    #     };
    #     Documents = {
    #       path = "${hl.mounts.fast}/Documents";
    #     };
    #     Media = {
    #       path = "${hl.mounts.merged}/Media";
    #     };
    #     Music = {
    #       path = "${hl.mounts.fast}/Media/Music";
    #     };
    #     Misc = {
    #       path = "${hl.mounts.merged}/Misc";
    #     };
    #     TimeMachine = {
    #       path = "${hl.mounts.fast}/TimeMachine";
    #       "fruit:time machine" = "yes";
    #     };
    #     YoutubeArchive = {
    #       path = "${hl.mounts.merged}/YoutubeArchive";
    #     };
    #     YoutubeCurrent = {
    #       path = "${hl.mounts.fast}/YoutubeCurrent";
    #     };
    #   };
    # };
    services = {
      enable = true;
      # backup = {
      #   enable = true;
      #   passwordFile = config.age.secrets.resticPassword.path;
      #   s3.enable = true;
      #   s3.url = "https://s3.eu-central-003.backblazeb2.com/notthebee-ojfca-backups";
      #   s3.environmentFile = config.age.secrets.resticBackblazeEnv.path;
      #   local.enable = true;
      # };

      # homepage = {
      #   enable = true;
      #   misc = [
      #   ];
      # };

      # jellyfin.enable = true;
      # paperless = {
      #   enable = true;
      #   passwordFile = config.age.secrets.paperlessPassword.path;
      # };
      # vaultwarden = {
      #   enable = true;
      #   cloudflared = {
      #     tunnelId = "3bcbbc74-3667-4504-9258-f272ce006a18";
      #     credentialsFile = config.age.secrets.vaultwardenCloudflared.path;
      #   };
      # };
      # audiobookshelf.enable = true;
    };
  };
}
