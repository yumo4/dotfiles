{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    ## dvd's and blu-ray's
    makemkv # dvd & blu-ray ripper
    handbrake # encoder

    # libdvdcss
    # libbluray
    # libaacs

    ## cd's
    abcde # cd's ripper
    cdparanoia
    lame # mp3
    flac # flac
  ];

  users.users.max = {
    # Replace 'max' with your actual username
    extraGroups = ["cdrom" "optical" "disk" "storage"];
  };

  # Enable additional hardware support
  hardware.enableRedistributableFirmware = true;

  # Optional: Enable automatic mounting of optical media
  # services.gvfs.enable = true;
  services.udisks2.enable = true;
  boot.kernelModules = ["sg"];

  # systemd.tmpfiles.rules = [
  #   "d /home/max/blueray 0755 max users -"
  # ];
  #
  # fileSystems."/mnt/bluray" = {
  #   # fileSystems."/home/max/bluray" = {
  #   # usb-HL-DT-ST_BD-RE_BU40N_0025034C2305-0:0
  #   device = "/dev/disk/by-id/usb-HL-DT-ST_BD-RE_BU40N_0025034C2305-0:0";
  #   fsType = "udf";
  #   options = ["x-systemd.automount"];
  # };
}
