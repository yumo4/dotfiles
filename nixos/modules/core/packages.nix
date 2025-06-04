{pkgs, ...}: {
  nix.settings.experimental-features = ["nix-command" "flakes"];
  environment.systemPackages = with pkgs; [
    bat
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
