{
  pkgs,
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
    extraGroups = ["networkmanager" "video" "wheel" "docker" "uinput"];
    shell = pkgs.fish;
    packages = with pkgs; [
      tree
      lsd
      fastfetch
    ];
    # openssh.authorizedKeys.keys = [
    #   (builtins.readFile ./keys/id_keyname.pub)
    # ];
  };
}
