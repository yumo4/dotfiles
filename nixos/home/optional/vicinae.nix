{config, ...}: {
  services.vicinae = {
    # enable = true;
    # autoStart = true;
    systemd = {
      enable = true;
      autoStart = true;
      environment = {
        USE_LAYER_SHELL = 1;
      };
    };
    # settings = {
    #   faviconService = "twenty";
    #   font = {
    #     size = 11;
    #     family = "JetBrains Mono";
    #   };
    #   theme.name = "gruvbox-dark";
    #   window = {
    #     csd = true;
    #     # opacity = 0.95;
    #     opacity = 1.00;
    #     rounding = 10;
    #   };
    # };
  };
}
