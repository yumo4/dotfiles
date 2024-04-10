if status is-interactive
    # Commands to run in interactive sessions can go here
alias vim "nvim"
alias fetch "nerdfetch"
alias ll "ls -l"
alias ls "lsd"
alias lst "tree -C"
alias ta "tmux attach"
alias FHWS "fortivpn connect FHWS -u k61965 -p -s"

set -g fish_greeting ""
# pomodoro timer

set -gx work_duration 25
set -gx break_duration 5

function pomodoro
  if test -n "$argv[1]"
    set val $argv[1]
    echo $val | lolcat
    switch $val
      case 'work'
        timer $work_duration'm'
      case 'break'
        timer $break_duration'm'
    end
    spd-say "'$val' session done"
  end
end

abbr wo 'pomodoro work'
abbr br 'pomodoro break'

end
