{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.niri.homeModules.niri ./settings.nix ./keybinds.nix ./rules.nix];

  home = {
    packages = with pkgs; [
      seatd
      jaq
      swaybg
      swayosd
      # xwayland-satellite
      gnome-control-center
    ];
  };
}
