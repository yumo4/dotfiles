{
  pkgs,
  inputs,
  ...
}: let
  gruvboxPkg =
    inputs.gruvbox-material-gtk.packages.${pkgs.system}.default;
in {
  services.swaync = {
    enable = true;
  };

  qt = {
    enable = true;
  };

  gtk = {
    enable = true;

    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    # iconTheme.name = "Gruvbox-Material-Dark";
    # theme = {
    #   name = "Gruvbox-Material-Dark";
    #   package = gruvboxPkg;
    # };

    iconTheme = {
      name = "Gruvbox-Material-Dark";
      package = gruvboxPkg;
    };

    font.name = "JetBrainsMono Nerd Font";
  };
}
