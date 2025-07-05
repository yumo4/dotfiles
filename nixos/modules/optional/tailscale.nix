{
  pkgs,
  meta,
  ...
}: let
  extraSetFlags =
    if meta.isServer
    then ["--advertise-exit-node"]
    else [];
in {
  environment.systemPackages = with pkgs; [
    tailscale
  ];

  # NOTE:
  # setup: sudo tailscale up

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
    openFirewall = true;
    extraSetFlags = extraSetFlags;
  };
}
