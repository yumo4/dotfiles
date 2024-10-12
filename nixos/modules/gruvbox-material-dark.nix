{ pkgs }: 

pkgs.stdenv.mkDerivation {
  name = "gruvbox-material-dark"

  src = pkgs.fetchurl {
      url = "https://github.com/TheGreatMcPain/gruvbox-material-gtk";
      sha256 = "";

  };
}
