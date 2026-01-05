{
  inputs,
  config,
  pkgs,
  ...
}: let
  inherit (config.lib.file) mkOutOfStoreSymlink;
  # pythonWithDeps = pkgs.python3.withPackages (ps:
  #   with pkgs; [
  #     # (pywayfire ps)
  #     # ps.pip
  #   ]);
in {
  xdg.configFile.quickshell.source = mkOutOfStoreSymlink "/home/max/Projects/dotfiles/dots/.config/quickshell/";
  home.packages = with pkgs; [
    inputs.quickshell.packages.${pkgs.system}.default
    cliphist
    libnotify
    inotify-tools
    socat
    desktop-file-utils
    kdePackages.qtdeclarative
  ];
  xdg.configFile."nvim/queries/qml".source = "${pkgs.neovim}/share/nvim/runtime/queries/qml";
}
