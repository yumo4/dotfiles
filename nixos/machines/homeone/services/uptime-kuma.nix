{
  pkgs,
  config,
  ...
}: let
in {
  # TODO: Port, Host, Domain Stuff

  services.uptime-kuma = {
    enable = true;
  };
}
