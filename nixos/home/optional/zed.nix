{pkgs, ...}: {
  programs.zed-editor = {
    enable = true;
    themes = {
      mode = "dark";
      dark = "Gruvbox Dark Hard";
    };
    extensions = ["nix" "php" "html" "latex" "lua" "java" "toml"];
    # userTasks = {};
    # userKeymaps = {
    #   # Clear search highlight (Esc in normal mode)
    #   "n esc" = "vim::ClearHighlights";
    #
    #   # jj to escape from insert mode
    #   "i j j" = "vim::NormalMode";
    #
    #   # Diagnostic navigation
    #   "n [ d" = "editor::GoToPrevDiagnostic";
    #   "n ] d" = "editor::GoToNextDiagnostic";
    #   "n space e" = "editor::Hover";
    #   "n space q" = "diagnostics::Deploy";
    #
    #   # Split navigation (Ctrl+hjkl)
    #   "n ctrl-h" = "pane::ActivateLeft";
    #   "n ctrl-l" = "pane::ActivateRight";
    #   "n ctrl-j" = "pane::ActivateDown";
    #   "n ctrl-k" = "pane::ActivateUp";
    #
    #   # Insert mode navigation (Ctrl+hjkl)
    #   "i ctrl-h" = "editor::MoveLeft";
    #   "i ctrl-l" = "editor::MoveRight";
    #   "i ctrl-j" = "editor::MoveDown";
    #   "i ctrl-k" = "editor::MoveUp";
    #
    #   # Move selected text up/down (Visual mode J/K)
    #   "v shift-j" = "editor::MoveLineDown";
    #   "v shift-k" = "editor::MoveLineUp";
    #
    #   # Vertical split
    #   "n space v s" = "pane::SplitRight";
    #
    #   # Execute/source commands (using closest Zed equivalents)
    #   "n space x" = "editor::Format";
    #   "n space space x" = "editor::Reload";
    #   "v space x" = "editor::Format";
    # };
    userSettings = {
      features = {
        copilot = false;
      };
      telemetry = {
        metrics = false;
      };
      vim_mode = true;
      ui_font_size = 12;
      buffer_font_size = 12;
      # gutter = {
      #   line_numbers = true;
      #   code_actions = true;
      #   runnables = true;
      #   folds = true;
      # };
      relative_line_numbers = true;

      # Mouse support
      mouse = true;

      # Indentation settings (equivalent to shiftwidth=4, tabstop=4)
      # indent_guides = {
      #   enabled = true;
      #   line_width = 1;
      #   active_line_width = 1;
      #   coloring = "indent_aware";
      # };
      # hard_tabs = false;
      # tab_size = 4;
      # soft_wrap = "editor_width";

      # Search settings (equivalent to ignorecase, smartcase)
      search = {
        case_sensitive = false;
        whole_word = false;
        include_ignored = false;
        regex = false;
      };

      # Editor behavior
      # cursor_blink = false;
      # hover_popover_enabled = true;
      # show_completions_on_input = true;
      # show_completion_documentation = true;
      # completion_documentation_secondary_query_debounce = 300;
      #
      # Scrolling (equivalent to scrolloff=10)
      # scroll_beyond_last_line = "one_page";
      # scrollbar = {
      #   show = "auto";
      #   cursors = true;
      #   git_diff = true;
      #   search_results = true;
      #   selected_symbol = true;
      #   diagnostics = true;
      # };

      # Visual settings (equivalent to list, listchars, cursorline)
      # show_whitespaces = "selection";
      # current_line_highlight = "line";

      # Split behavior (equivalent to splitright, splitbelow)
      # always_treat_brackets_as_autoclosed = false;

      # Diagnostics and inlay hints
      # show_inline_completions = true;
      # inlay_hints = {
      #   enabled = true;
      #   show_type_hints = true;
      #   show_parameter_hints = true;
      #   show_other_hints = true;
      #   edit_debounce_ms = 700;
      #   scroll_debounce_ms = 50;
      # };

      # Vim mode settings (equivalent to clipboard="unnamedplus")
      vim = {
        use_system_clipboard = "always";
        use_multiline_find = true;
        use_smartcase_find = true;
        custom_digraphs = {};
      };

      # Additional useful settings
      buffer_font_family = "Jetbrains";

      # File tree
      # project_panel = {
      #   button = true;
      #   default_width = 240;
      #   dock = "left";
      #   file_icons = true;
      #   folder_icons = true;
      #   git_status = true;
      #   indent_size = 20;
      #   auto_fold_dirs = true;
      #   auto_reveal_entries = true;
      # };

      # Terminal settings
      terminal = {
        blinking = "terminal_controlled";
        copy_on_select = false;
        dock = "bottom";
        default_width = 640;
        default_height = 320;
        working_directory = "current_project_directory";
        shell = "system";
      };

      # Git integration
      git = {
        inline_blame = {
          enabled = true;
          delay_ms = 600;
        };
      };

      # Auto-save
      autosave = "on_focus_change";

      # Collaboration panel
      collaboration_panel = {
        button = false;
        dock = "left";
        default_width = 240;
      };

      # Language server settings
      # lsp = {
      #   rust-analyzer = {
      #     initialization_options = {
      #       checkOnSave = {
      #         command = "clippy";
      #       };
      #     };
      #   };
      # };
    };
    # extraPackages = {};
  };
}
