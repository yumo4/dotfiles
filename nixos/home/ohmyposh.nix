{...}: {
  enable = true;
  enableZshIntegration = true;
  enableFishIntegration = true;
  settings = builtins.fromTOML (builtins.unsafeDiscardStringContext (builtins.readFile ../../dots/.config/ohmyposh/config.toml));
}
