{pkgs, ...}:

  {
  enable = true;
  baseIndex = 1;
  disableConfirmationPrompt = true;
  keyMode = "vi";
  newSession = true;
  secureSocket = true;
  shell = "${pkgs.zsh}/bin/zsh";
  shortcut = "a";
  terminal = "screen-256color";
  plugins = with pkgs.tmuxPlugins; [
      yank
      sensible
      vim-tmux-navigator
      tmux-nova
      resurrect
      continuum
    ];
  extraConfig = ''
      # fixes colorscheme
      set -g default-terminal "screen-256color"
      set-option -sa terminal-overrides ",xterm*:Tc"
      # Set prefix
      set -g prefix C-Space
      # unbind so comment shortcut in nvim works
      set -s extended-keys on
      set-option -g xterm-keys on
      set -as terminal-features 'xterm*:extkeys'
      unbind-key C-/
      # Shift Alt vim keys to switch windows 
      bind -n M-H previous-window
      bind -n M-L next-window
      # switch like vim
      setw -g mode-keys vi
      bind-key C-h select-pane -L
      bind-key C-j select-pane -D
      bind-key C-k select-pane -U
      bind-key C-l select-pane -R
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
      # resizes panes
      bind -r j resize-pane -D 5
      bind -r k resize-pane -U 5
      bind -r l resize-pane -R 5
      bind -r h resize-pane -L 5

      bind -r m resize-pane -Z
      # opens splits in current directory
      # tmux is weird -> v and h are switched
      bind h split-window -v -c '#{pane_current_path}'
      bind v split-window -h -c '#{pane_current_path}'
      # mousesupport
      set -g mouse on
      # bar
      set-option -g status-position bottom
      # colortheme
      set -g @nova-nerdfonts true
      set -g @nova-nerdfonts-left "█"
      set -g @nova-nerdfonts-right "█"

      set -g @nova-pane "#I#{?pane_in_mode, #{pane_mode},} #W"

      ## bar background
      set -g @nova-status-style-bg "#32302f"
      ## active pane border
      set -g @nova-pane-active-border-style "#ebdbb2"
      ## active window
      set -g @nova-status-style-active-bg "#ebdbb2"
      set -g @nova-status-style-active-fg "#282828"

      #set -g @nova-segment-mode "#{?client_prefix, P, T}"
      set -g @nova-segment-mode "#{?client_prefix,,}"
      set -g @nova-segment-mode-colors "#ebdbb2 #282828"

      set -g @nova-rows 0
      set -g @nova-segments-0-left "mode"

      # index starts at 1
      set -g base-index 1
      set -g pane-base-index 1
      set-window-option -g pane-base-index 1
      set-option -g renumber-windows on

      set -g @resurrect-capture-pane-contents 'on'
      set -g @continuum-restore 'on'
  '';
}
