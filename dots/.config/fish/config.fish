# if status is-interactive
#    # Commands to run in interactive sessions can go here
alias vim "nvim"
alias fetch "fastfetch"
alias ll "lsd -l"
alias ls "lsd"
alias lst "tree -C"
alias tas="tmux attach-session -t"

oh-my-posh init fish --config $HOME/.config/ohmyposh/config.toml | source
end

# export PATH=$PATH:$(go env GOPATH)/bin
#
# if [ -e /home/max/.nix-profile/etc/profile.d/nix.sh ]; then . /home/max/.nix-profile/etc/profile.d/nix.sh; 
# end # added by Nix installer

# Enable vi key bindings
fish_vi_key_bindings

# Configure FZF completion
set -U FZF_COMPLETE 0
set -U FZF_DEFAULT_OPTS "--bind 'ctrl-y:accept'"

set -g fish_greeting "" 
set fish_cursor_default block
set fish_cursor_insert block
set fish_color_autosuggestion brblack

function fish_mode_prompt
    # No body, just an empty function
end

function fish_user_key_bindings
    # Insert mode bindings
    bind --mode insert ctrl-y accept-autosuggestion
    bind --mode insert ctrl-n down-or-search
    bind --mode insert ctrl-p up-or-search
end

zoxide init fish | source
