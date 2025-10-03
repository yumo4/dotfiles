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
        # NOTE: this "forces" git to use a specific ssh key for GitHub
        "github.com" = {
          host = "github.com";
          identitiesOnly = true;
          identityFile = [
            "~/.ssh/id_${meta.hostname}"
            # NOTE: to add other keys (such as yubikeys) (order matters) do this:
            # "~/.ssh/id_someotherid"
          ];
        };
      }
      // (
        # NOTE: Only work machines get GitLab access
        if meta.isWork
        then {
          "gitlab.fly.internal.de" = {
            host = "gitlab.fly.internal.de";
            identitiesOnly = true;
            identityFile = [
              "~/.ssh/id_${meta.hostname}"
              # NOTE: to add other keys (such as yubikeys) (order matters) do this:
              # "~/.ssh/id_someotherid"
            ];
          };
        }
        else {}
      );
  };
}
