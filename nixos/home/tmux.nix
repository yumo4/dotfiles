{pkgs, ...}: {
  enable = true;
  shell = "${pkgs.zsh}/bin/zsh";
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
      plugin = tmux-nova;
      extraConfig = ''
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
      '';
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
    set -g prefix C-Space
    # unbind so comment shortcut in nvim works
    set -s extended-keys on
    # set-option -g xterm-keys on
    set -as terminal-features 'xterm*:extkeys'
    # fixes colorscheme
    set -g default-terminal "screen-256color"
    set-option -sa terminal-overrides ",xterm*:Tc"
    bind C-j display-popup -E "tmux list-sessions | sed -E 's/:.*$//' | grep -v \"^$(tmux display-message -p '#S')\$\" | fzf --reverse | xargs tmux switch-client -t"
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

    bind -r m resize-pane -Z
    # bar position
    # set-option -g status-position bottom
    # index
    set -g base-index 1
    set -g pane-base-index 1
    set-window-option -g pane-base-index 1
    set-option -g renumber-windows on
  '';
}
