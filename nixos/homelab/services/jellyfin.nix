{
  pkgs,
  config,
  ...
}: let
  baseDomain = "yumo4.dev";
  subDomain = "jellyfin";
  port = 8096;
in {
  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
  ];

  # intro skipper plugin
  nixpkgs.overlays = with pkgs; [
    (
      final: prev: {
        jellyfin-web = prev.jellyfin-web.overrideAttrs (finalAttrs: previousAttrs: {
          installPhase = ''
            runHook preInstall

            # this is the important line
            sed -i "s#</head>#<script src=\"configurationpage?name=skip-intro-button.js\"></script></head>#" dist/index.html
            # sed -i "s#</head>#<script src=\"configurationpage?name=skip-intro-button.js\"></script><script src=\"configurationpage?name=InPlayerEpisodePreview.js\"></script></head>#" dist/index.html
            # sed -i "s#</head>#<script src=\"configurationpage?name=skip-intro-button.js\"></script><script src=\"configurationpage?name=InPlayerEpisodePreview.js\"></script></head>#" dist/index.html

            # sed -i "s#</head>#<script src=\"configurationpage?name=skip-intro-button.js\"></script><script src=\"configurationpage?name=inPlayerEpisodePreview.js\"></script></head>#" dist/index.html

            mkdir -p $out/share
            cp -a dist $out/share/jellyfin-web

            runHook postInstall
          '';
        });
      }
    )
  ];

  services.jellyfin = {
    enable = true;
    openFirewall = true;
    # port = port;
    user = "max";
  };

  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override {enableHybridCodec = true;};
  };
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      libva-vdpau-driver
      intel-compute-runtime
      vpl-gpu-rt
      intel-ocl
    ];
  };

  # Enable all firmware (needed for some Intel CPUs like N100)
  hardware.enableAllFirmware = true;

  # Set VA-API driver - use "iHD" for newer Intel (Broadwell 2014+) or "i965" for older
  systemd.services.jellyfin.environment.LIBVA_DRIVER_NAME = "iHD";
  environment.sessionVariables = {LIBVA_DRIVER_NAME = "iHD";};

  homelab.services.jellyfin = {
    homepage = {
      name = "Jellyfin";
      description = "";
      icon = "jellyfin.svg";
      category = "Media";
    };
    url = "${subDomain}.${baseDomain}";
  };

  services.caddy = {
    virtualHosts."${subDomain}.${baseDomain}" = {
      useACMEHost = baseDomain;

      extraConfig = ''
        reverse_proxy http://127.0.0.1:${toString port}
      '';
    };
  };
}
