{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # podman
    # podman-compose
    docker
    docker-compose
  ];

  virtualisation.docker = {
    enable = true;
    # dockerCompat = true;
    # NOTE: don't know what this does
    # defaultNetwork.settings = {
    #   dns_enabled = false; #true;
    # };
    # rootless = {
    #   enable = true;
    #   setSocketVariable = true;
    # };
  };

  # virtualisation.docker.rootless = {
  #   enable = true;
  #   setSocketVariable = true;
  # };
}
