{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    btop
    fd
    fish
    fzf
    git
    jetbrains-mono
    neovim
    oh-my-posh
    ripgrep
    tmux
    wget
    # wl-clipboard
    zoxide
  ];
}
