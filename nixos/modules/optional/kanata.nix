{pkgs, ...}: {
  services.kanata = {
    enable = true;
    keyboards = {
      internalKeyboard = {
        devices = [
          "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
        ];
        extraDefCfg = "process-unmapped-keys yes";
        config = ''
          (defsrc
           caps a s d f spc j k l ;
          )
          (defvar
           tap-time 150
           hold-time 200
          )
          (defalias
           caps esc
           a (tap-hold $tap-time $hold-time a lmet)
           s (tap-hold $tap-time $hold-time s lalt)
           d (tap-hold $tap-time $hold-time d lsft)
           f (tap-hold $tap-time $hold-time f lctl)
           j (tap-hold $tap-time $hold-time j lctl)
           k (tap-hold $tap-time $hold-time k lsft)
           l (tap-hold $tap-time $hold-time l lalt)
           ; (tap-hold $tap-time $hold-time ; lmet)
           spc (tap-hold $tap-time $hold-time spc (layer-toggle extra))
          )

          (deflayer base
           3   4   @caps @a  @s  @d  @f  @spc h  @j  @k  @l  @;  u  o  bspc
          )
          (deflayer extra
           §   €   _     ä   ß   _   _   _    left down up right _   ü  ö  del
          )
        '';
      };
    };
  };
}
