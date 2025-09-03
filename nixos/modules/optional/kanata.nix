{pkgs, ...}: {
  services.kanata = {
    enable = true;
    keyboards = {
      internalKeyboard = {
        # NOTE: to get a new device
        # ls -la /dev/input/by-path/ | grep kbd
        devices = [
          "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
        ];
        extraDefCfg = "process-unmapped-keys yes";
        config = ''
          (defsrc
           3 4 caps a s d f spc h j k l ; u o bspc
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

           section (multi ralt S-s)        ;; §
           euro (multi ralt 5)             ;; €
           a-umlaut (tap-hold $tap-time $hold-time (multi ralt q) lmet)  ;; ä
           eszett (tap-hold $tap-time $hold-time (multi ralt s) lalt)    ;; ß
           u-umlaut (multi ralt y)         ;; ü
           o-umlaut (multi ralt p)         ;; ö


           e-down (tap-hold $tap-time $hold-time down lsft)
           e-up (tap-hold $tap-time $hold-time up lalt)
           e-right (tap-hold $tap-time $hold-time right lmet)
           e-; (tap-hold $tap-time $hold-time ; lmet)
          )

          (deflayer base
           3 4 @caps @a  @s  @d  @f  @spc h  @j  @k  @l  @;  u  o  bspc
          )
          (deflayer extra
           @section @euro _ @a-umlaut @eszett lsft lctl _ left down up right _ @u-umlaut @o-umlaut del
          )
        '';
      };
    };
  };
}
