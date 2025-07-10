{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: let
  username = "max";
  secretspath = builtins.toString inputs.mysecrets;
in {
  imports = [inputs.sops-nix.nixosModules.sops];
  sops = {
    defaultSopsFile = "${secretspath}/secrets.yaml";
    validateSopsFiles = false;

    secrets = {
      "samba-password" = {};
    };
  };

  environment.systemPackages = with pkgs; [
    samba
    cifs-utils
    avahi
  ];
  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = "homeone samba";
        "netbios name" = "homeone samba";
        "security" = "user";
        "hosts allow" = "192.168.178. 127.0.0.1 localhost";
        "hosts deny" = "0.0.0.0/0";
        "guest account" = "nobody";
        "map to guest" = "bad user";
      };
      "media" = {
        "path" = "/home/max/Media";
        "browsable" = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "${username}";
        "force group" = "users";
      };
    };
  };
  system.activationScripts.createSambaUser = {
    text = ''
      smb_password=$(cat "${config.sops.secrets."samba-password".path}")
      echo -e "$smb_password\n$smb_password" | ${lib.getExe' pkgs.samba "smbpasswd"} -a -s ${username}
    '';
    deps = ["setupSecrets"];
  };

  # PASSWORD=${config.sops.secrets."samba-password".path}

  services.avahi = {
    enable = true;
    openFirewall = true;
    publish = {
      enable = true;
      userServices = true;
    };
    nssmdns4 = true;
  };

  # NOTE: for autodiscovery on windows
  # samba-wsdd = {
  #   enable = true;
  #   openFirewall = true;
  # };
}
