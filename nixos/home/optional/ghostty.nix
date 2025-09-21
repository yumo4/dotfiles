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
