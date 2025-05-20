{pkgs}: {
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    options = ["--cmd cd"];
  };
}
