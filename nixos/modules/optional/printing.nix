{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # cups
    avahi
    cups-filters
    # ghostscript
    hplip
  ];
  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.printing.drivers = with pkgs; [
    # hplip
    hplipWithPlugin
  ];

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
  hardware.printers = {
    ensurePrinters = [
      {
        name = "HP_Color_LaserJet_MFP_M277dw";
        location = "Home";
        deviceUri = "ipp://192.168.178.53:631/ipp/print";
        model = "everywhere";
        ppdOptions = {
          PageSize = "A4";
          Duplex = "DuplexNoTumble";
          HPOption_Duplexer = "True";
          # ColorModel = "Color";
        };
      }
    ];
    ensureDefaultPrinter = "HP_Color_LaserJet_MFP_M277dw";
  };
}
