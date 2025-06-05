{
  config,
  meta,
  ...
}: {
  programs.ssh = {
    enable = true;
    matchBlocks = {
      # NOTE: this "forces" git to use a specific ssh key
      # the name doesn't matter
      "block" = {
        host = "github.com";
        identitiesOnly = true;
        identityFile = [
          "~/.ssh/id_${meta.hostname}"
          # NOTE: to add other keys (such as yubikeys) (order matters) do this:
          # "~/.ssh/id_someotherid"
        ];
      };
    };
  };
}
