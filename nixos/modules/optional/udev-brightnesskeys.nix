{
  pkgs,
  lib,
  ...
}: {
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", MODE="0666"
  '';
}
