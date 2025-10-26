{
  pkgs,
  config,
  meta,
  ...
}: {
  programs.git = {
    enable = true;
    settings = {
      user = {
        name =
          if meta.isWork
          then "Maximilian Troester"
          else "yumo4";
        email =
          if meta.isWork
          then "maximilian.troester@flyeralarm.com"
          else "maximilian.troe@gmail.com";
      };
      # extraConfig = {
      init = {
        defaultBranch = "main";
      };
      commit.template = "${pkgs.writeText "git-commit-template" ''
        # feat():
        # fix():
        # chore():
        # docs():
        # style():
        # refactor():
        # perf():
        # test():
        # build():
        # ci():
        # revert():
      ''}";
      # };
    };
  };
}
