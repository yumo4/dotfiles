{pkgs, ...}: {
  programs.fish = {
    enable = true;
    plugins = with pkgs; [
      {
        name = "fzf";
        src = fishPlugins.fzf.src;
      }
    ];
    # ${pkgs.oh-my-posh}/bin/oh-my-posh init fish --config ${../../dots/.config/ohmyposh/config.toml} | source
    interactiveShellInit = ''
      fish_vi_key_bindings


      set -U FZF_COMPLETE 0
      # set -U FZF_COMPLETE 1
      set -U FZF_DEFAULT_OPTS "--bind 'ctrl-y:accept'"

      set -g fish_greeting ""
      set fish_cursor_default block
      set fish_cursor_insert block
      set fish_color_autosuggestion brblack
         # set fish_cursor_replace_one underscore
         # set fish_cursor_replace underscore
         # set fish_cursor_external line
         # set fish_cursor_visual block
    '';
    functions = {
      fish_mode_prompt = {
        body = '''';
      };
      fish_user_key_bindings = {
        body = ''
          bind --mode insert ctrl-y accept-autosuggestion
          bind --mode insert ctrl-n down-or-search
          bind --mode insert ctrl-p up-or-search

          # bind --mode insert \\t '__fzf_complete'
          # bind --mode insert ctrl-f '__fzf_complete'
        '';
      };
    };
  };
}
