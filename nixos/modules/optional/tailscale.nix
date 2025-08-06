{
  pkgs,
  meta,
  ...
}: {
  environment.systemPackages = with pkgs; [
    tailscale
  ];

  # NOTE:
  # setup:          sudo tailscale up
  # exit node:      sudo tailscale set --advertise-exit-node
  # subnet router: sudo tailscale set --advertise-routes 192.168.178.0/24

  networking.firewall.checkReversePath = "loose";
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
    openFirewall = true;
  };
}
