if status is-interactive
    # Commands to run in interactive sessions can go here
alias vim "nvim"
alias fetch "fastfetch"
alias ll "lsd -l"
alias ls "lsd"
alias lst "tree -C"
alias FHWS "fortivpn connect FHWS -u k61965 -p -s"
alias home-one "ssh max@192.168.178.65"

set -g fish_greeting ""

end

function starship_transient_prompt_func
  starship module character
end
starship init fish | source
enable_transience

# Generated for envman. Do not edit.
test -s ~/.config/envman/load.fish; and source ~/.config/envman/load.fish
