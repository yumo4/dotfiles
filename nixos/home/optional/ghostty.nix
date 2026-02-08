{...}: {
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    settings = {
      font-size = 10;
      font-family = "JetBrainsMono NF";
      font-feature = ["-calt" "-liga" "dlig"];
      font-thicken = true;

      theme = "Gruvbox Dark";
      # palette = [
      #   # 0-7: Normal colors
      #   "0=#000000"
      #   "1=#ff7676"
      #   "2=#86cd82"
      #   "3=#d9ba73"
      #   "4=#458ee6"
      #   "5=#f2a4db"
      #   "6=#5abfb5"
      #   "7=#b0b0b0"
      #   # 8-15: Bright colors
      #   "8=#50585d"
      #   "9=#ff7676"
      #   "10=#14ba19"
      #   "11=#ff5733"
      #   "12=#8ebeec"
      #   "13=#f2a4db"
      #   "14=#5abfb5"
      #   "15=#ffffff"
      # ];
      # background = "#101010";
      # foreground = "#b0b0b0";
      # cursor-color = "#50585d";
      # cursor-text = "#101010";
      # selection-background = "#458ee6";
      # selection-foreground = "#101010";

      cursor-style = "block";
      cursor-click-to-move = true;
      cursor-style-blink = false;
      shell-integration-features = "no-cursor";

      confirm-close-surface = false;
      window-decoration = false;
      window-padding-x = 6;
      window-padding-y = 4;
      resize-overlay = "never";
      focus-follows-mouse = true;
      mouse-hide-while-typing = true;
      keybind = [
        "ctrl+g>r=reload_config"
        "ctrl+enter=ignore"
      ];
    };
  };
}
