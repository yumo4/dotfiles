if status is-interactive
#    # Commands to run in interactive sessions can go here
alias vim "nvim"
alias fetch "fastfetch"
alias ll "lsd -l"
alias ls "lsd"
alias lst "tree -C"
alias tas="tmux attach-session -t"
alias FHWS "fortivpn connect FHWS -u k61965 -p -s"
alias home-one "ssh max@192.168.178.65"
alias homec="sudo wg-quick up wg_config"
alias homedc="sudo wg-quick down wg_config"

set -g fish_greeting ""

oh-my-posh init fish --config $HOME/.config/ohmyposh/config.toml | source
end

export PATH=$PATH:$(go env GOPATH)/bin

if [ -e /home/max/.nix-profile/etc/profile.d/nix.sh ]; then . /home/max/.nix-profile/etc/profile.d/nix.sh; 
end # added by Nix installer

# Generated for envman. Do not edit.
#test -s ~/.config/envman/load.fish; and source ~/.config/envman/load.fish
