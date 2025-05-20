{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    btop
    fd
    fish
    fzf
    gammastep
    git
    jetbrains-mono
    nerd-fonts.jetbrains-mono
    neovim
    oh-my-posh
    ripgrep
    tmux
    wget
    # wl-clipboard
    zoxide
  ];
}
