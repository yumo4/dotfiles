{config, ...}: let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in {
  xdg.enable = true;
  xdg.configFile.nvim.source = mkOutOfStoreSymlink "/home/max/Projects/dotfiles/dots/.config/nvim";
}
