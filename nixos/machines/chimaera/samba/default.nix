{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: let
  secretspath = builtins.toString inputs.mysecrets;
in {
  imports = [inputs.sops-nix.nixosModules.sops];

  sops = {
    defaultSopsFile = "${secretspath}/secrets.yaml";
    validateSopsFiles = false;

    secrets = {
      "samba-password" = {};
    };
    templates = {
      "samba-credentials".content = ''
        username=max
        domain=WORKGROUP
        password=${config.sops.placeholder.samba-password}
      '';
    };
  };

  environment.systemPackages = with pkgs; [
    cifs-utils
    gvfs
    samba
  ];

  services.gvfs.enable = true;
  services.udisks2.enable = true;

  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        "workgroup" = "WORKGROUP";
      };
    };
  };

  # ensuring the directory exists
  systemd.tmpfiles.rules = [
    "d /home/max/Media 0755 max users -"
    # "d /home/max/Media/Audiobooks 0755 max users -"
    # "d /home/max/Media/Movies 0755 max users -"
    # "d /home/max/Media/Shows 0755 max users -"
  ];
  # mounting the share
  fileSystems."/home/max/Media" = {
    device = "//192.168.178.65/media";
    fsType = "cifs";
    # options = let
    #   # automounts_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,user,users";
    #   automounts_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
    # in ["${automounts_opts},credentials=${config.sops.templates."samba-credentials".path},uid=1000,gid=100"];
    options = [
      "x-systemd.automount"
      "noauto"
      "x-systemd.idle-timeout=60"
      "x-systemd.device-timeout=5s"
      "x-systemd.mount-timeout=5s"
      "credentials=${config.sops.templates."samba-credentials".path}"
      "uid=1000"
      "gid=100"
      # both with and without this:
      "user"
      "users"
    ];
  };
  # systemd.mounts = [
  #   {
  #     what = "//192.168.178.65/audiobooks";
  #     where = "/home/max/Media/Audiobooks";
  #     type = "cifs";
  #     options = "credentials=${config.sops.templates."samba-credentials".path},uid=1000,gid=100";
  #   }
  # ];
  #
  # systemd.automounts = [
  #   {
  #     where = "/home/max/Media/Audiobooks";
  #     wantedBy = ["multi-user.target"];
  #   }
  # ];
}
