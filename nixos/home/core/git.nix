{
  pkgs,
  config,
  meta,
  ...
}: {
  programs.git = {
    enable = true;
    includes = [
      {
        condition = "hasconfig:remote.*.url:git@github.com:*/**";
        contents = {
          user = {
            name = "yumo4";
            email = "maximilian.troe@gmail.com";
          };
        };
      }
      {
        # condition = "hasconfig:remote.*.url:git@codeberg.org:*/**";
        condition = "hasconfig:remote.*.url:ssh://git@codeberg.org/**";
        contents = {
          user = {
            name = "yumo";
            email = "maximilian.troester@protonmail.com";
          };
        };
      }
      {
        condition = "hasconfig:remote.*.url:git@gitlab.fly-internal.de:*/**";
        contents = {
          user = {
            name = "Maximilian Troester";
            email = "maximilian.troester@flyeralarm.com";
          };
        };
      }
    ];
    settings = {
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
    };
  };
}
