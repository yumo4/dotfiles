{
  self,
  inputs,
  ...
}: {
  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    # settings = builtins.fromTOML (builtins.unsafeDiscardStringContext (builtins.readFile inputs.self + "../../../dots/.config/ohmyposh/config.toml"));
    settings = {
      console_title_template = "{{ .Shell }} in {{ .Folder }}";
      version = 3;
      final_space = true;

      secondary_prompt = {
        template = "➜➜";
        foreground = "yellow";
        background = "transparent";
      };

      transient_prompt = {
        template = "➜ ";
        background = "transparent";
        foreground_templates = [
          "{{if gt .Code 0}}red{{end}}"
          "{{if eq .Code 0}}yellow{{end}}"
        ];
      };

      blocks = [
        {
          type = "prompt";
          alignment = "left";
          newline = true;
          segments = [
            {
              template = "{{ .Path }}";
              foreground = "cyan";
              background = "transparent";
              type = "path";
              style = "plain";
              properties = {
                style = "full";
              };
            }
            {
              template = " {{ .HEAD }}{{ if or (.Working.Changed) (.Staging.Changed) }}<yellow>*</>{{ end }} <cyan>{{ if gt .Behind 0 }}⇣{{ end }}{{ if gt .Ahead 0 }}⇡{{ end }}</>";
              foreground = "p:grey";
              background = "transparent";
              type = "git";
              style = "plain";
              properties = {
                branch_icon = "";
                commit_icon = "@";
                fetch_status = true;
              };
            }
          ];
        }
        {
          type = "prompt";
          alignment = "left";
          segments = [
            {
              template = "{{ if .SSHSession }} {{ .UserName }}@{{ .HostName }}<yellow>󰌘</>{{ end }}";
              foreground = "p:grey";
              background = "transparent";
              type = "session";
              style = "plain";
            }
          ];
        }
        {
          type = "prompt";
          alignment = "left";
          newline = true;
          segments = [
            {
              template = "➜";
              background = "transparent";
              type = "text";
              style = "plain";
              foreground_templates = [
                "{{if gt .Code 0}}red{{end}}"
                "{{if eq .Code 0}}yellow{{end}}"
              ];
            }
          ];
        }
      ];
    };
  };
}
