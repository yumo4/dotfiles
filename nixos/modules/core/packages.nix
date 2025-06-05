{pkgs, ...}: {
  nix.settings.experimental-features = ["nix-command" "flakes"];
  environment.systemPackages = with pkgs; [
    age
    bat
    btop
    fd
    fish
    fzf
    gammastep
    git
    jetbrains-mono
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
