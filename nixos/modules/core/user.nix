{
  pkgs,
  meta,
  # config,
  # inputs,
  ...
}: {
  # sops.secrets.max-password.neededForUsers = true;
  # users.mutableUsers = false;

  users.users.max = {
    isNormalUser = true;
    description = "max";
    # hashedPasswordFile = config.sops.secrets.max-password.paht;
    extraGroups =
      if meta.isServer
      then ["networkmanager" "wheel" "docker"]
      else ["networkmanager" "video" "wheel" "docker" "uinput" "scanner" "lp"];

    shell = pkgs.fish;
    packages = with pkgs; [
      tree
      lsd
      fastfetch
    ];
    openssh.authorizedKeys.keys = [
      (builtins.readFile ../keys/id_chimaera.pub)
      (builtins.readFile ../keys/id_framework.pub)
    ];
  };
}
