{...}: {
  home.shell.enableFishIntegration = true;
  home.shellAliases = {
    vi = "nvim";
    vim = "nvim";
    fetch = "fastfetch";
    ls = "lsd";
    ll = "lsd -l";
    lst = "tree -C";
    cat = "bat";
    tas = "tmux attach-session -t";
  };
}
