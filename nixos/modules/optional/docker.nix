{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    podman
  ];

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    # NOTE: don't know what this does
    defaultNetwork.settings = {
      dns_enabled = false; #true;
    };
  };
}
