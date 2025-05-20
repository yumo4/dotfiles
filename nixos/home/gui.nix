{pkgs, ...}: {
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
    iconTheme.name = "Gruvbox-Material-Dark";

    font.name = "JetBrainsMono Nerd Font";
  };
}
