{
  config,
  meta,
  ...
}: {
  services.ssh-agent.enable = true;
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks =
      {
        "*" = {
          addKeysToAgent = "yes";
        };
        "github" = {
          host = "github.com";
          identitiesOnly = true;
          identityFile = [
            "~/.ssh/id_${meta.hostname}"
            # NOTE: to add other keys (such as yubikeys) (order matters) do this:
            # "~/.ssh/id_someotherid"
          ];
        };
        "codeberg" = {
          host = "codeberg.org";
          identitiesOnly = true;
          identityFile = [
            "~/.ssh/id_${meta.hostname}"
          ];
        };
      }
      // (
        if meta.isWork
        then {
          "work" = {
            host = "gitlab.fly-internal.de";
            identitiesOnly = true;
            addKeysToAgent = "yes";
            identityFile = [
              "~/.ssh/id_${meta.hostname}"
            ];
          };
        }
        else {}
      );
  };
}
