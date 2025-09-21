# NOTE: use `lualatex`
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # texlab
    ltex-ls
    tex-fmt
    (texlive.combine {
      inherit
        (pkgs.texlive)
        scheme-small # Basic scheme with essential packages
        academicons # Academic icons
        arydshln # Dashed lines in arrays and tabulars
        fontawesome5 # Font Awesome 5 icons
        marvosym # Martin Vogel's symbols
        moderncv # CV document class
        multirow
        ;
    })
  ];
  fonts.packages = with pkgs; [
    open-sans
  ];
}
