{pkgs, ...}: {
  nix.settings.experimental-features = ["nix-command" "flakes"];
  environment.systemPackages = with pkgs; [
    age
    bat
    btop
    dnsutils
    fd
    fish
    fzf
    gammastep
    git
    inetutils
    jetbrains-mono
    just
    neovim
    nerd-fonts.jetbrains-mono
    oh-my-posh
    ripgrep
    sops
    tmux
    wget
    zoxide
  ];
}
