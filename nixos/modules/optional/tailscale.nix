{
  pkgs,
  meta,
  ...
}:
# let
# extraSetFlags =
#   if meta.isServer
#   then ["--advertise-exit-node" "--advertise-routes 192.168.178.0/24"]
#   else [];
# in
{
  environment.systemPackages = with pkgs; [
    tailscale
  ];

  # NOTE:
  # setup: sudo tailscale up

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
    openFirewall = true;
    # extraSetFlags = extraSetFlags;
  };
}
