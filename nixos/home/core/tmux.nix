{
  pkgs,
  meta,
  ...
}: let
  fgactive = "#ebdbb2";
  fginactive = "#665c54";
  background = "282828";
  prefix =
    if meta.isServer
    then "C-a"
    else "C-Space";
in {
  programs.tmux = {
    enable = true;
    shell = "${pkgs.fish}/bin/fish";
    keyMode = "vi";
    mouse = true;
    terminal = "screen-256color";
    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = yank;
      }
      {
        plugin = sensible;
      }
      {
        plugin = vim-tmux-navigator;
      }
      {
        plugin = resurrect;
        extraConfig = ''
          set -g @resurrect-capture-pane-contents 'on'
        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '10'
        '';
      }
    ];
    extraConfig = ''
      # Set prefix
      set -g prefix ${prefix}

      # unbind so comment shortcut in nvim works
      set -s extended-keys on

      # set-option -g xterm-keys on
      set -as terminal-features 'xterm*:extkeys'

      # fixes colorscheme
      set -g default-terminal "screen-256color"
      set-option -sa terminal-overrides ",xterm*:Tc"

      # session switching
      bind s display-popup -E "$HOME/Projects/dotfiles/scripts/tmux-list-sesssions.sh"

      # reload config
      bind r source-file ~/.config/tmux/tmux.conf

      # switch like vim
      bind-key C-h select-pane -L
      bind-key C-j select-pane -D
      bind-key C-k select-pane -U
      bind-key C-l select-pane -R
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

      # opens splits in current directory
      # tmux is weird -> v and h are switched
      bind h split-window -v -c '#{pane_current_path}'
      bind v split-window -h -c '#{pane_current_path}'

      # pop up / floating
      unbind t
      bind t display-popup \
      -w 80% \
      -h 80% \
      -d "#{pane_current_path}" \
      -E "fish"

      # resize pane
      bind -r m resize-pane -Z
      bind-key m resize-pane -Z

      # bar
      # bar position
      # set-option -g status-position bottom
      # index
      set -g base-index 1
      set -g pane-base-index 1
      set-window-option -g pane-base-index 1
      set-option -g renumber-windows on

      set -g status on
      set -g status-justify left
      set -g status-style "fg=${fgactive}"
      set -g status-left " #{?client_prefix, , }"
      # set -g status-left "#[fg=#282828]█#[fg=#ebdbb2]{?client_prefix,  }#[fg=#282828]█"
      set -g status-right-length 50

      set -g status-right " #[fg=${fginactive}] session:#[fg=${fgactive},bg=default] #S"
      set -g window-status-format " #[fg=${fginactive},bg=default]#I: #[fg=#default,bg=${fgactive}]#W"

      set -g window-status-current-format " #[fg=${fgactive},bg=default]#I: #[fg=${fginactive},bg=#default]#W"

      # pane dividers
      set -g pane-border-style "fg=${fginactive}"
      set -g pane-active-border-style "fg=${fgactive}"
    '';
  };
}
