{pkgs, ...}: {
  users.users.max = {
    isNormalUser = true;
    description = "max";
    extraGroups = ["networkmanager" "video" "wheel" "docker" "uinput"];
    shell = pkgs.fish;
    packages = with pkgs; [
      tree
      lsd
      fastfetch
    ];
  };
}
