#!/usr/bin/env bash
tmux list-sessions | sed -E 's/:.*$//' | grep -v \"^$(tmux display-message -p '#S')\$\" | fzf --reverse | xargs tmux switch-client -t

# chosen_session=$(tmux list-sessions | sed -E 's/:.*$//' | grep -v "^$(tmux display-message -p '#S')$" | fzf --reverse)
#
# if [ -n "$chosen_session" ]; then
#   tmux switch-client -t "$chosen_session"
#   # tmux display-message "Switched to session: $chosen_session" # Optional confirmation
#   tmux send-keys escape
# fi

