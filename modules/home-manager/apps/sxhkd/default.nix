{ config, lib, pkgs, ... }:

{
  services.sxhkd = {
    enable = true;
    keybindings = {
      "super + return" = "wezterm";
      "super + p" = "dmenu_run";
      "super + {_,shift + }w" = "bspc node -{c,k}";
      "super + {_,shift + }{h,j,k,l}" = "bspc node -{f,s} {west,south,north,east}"; # focus the node in the given direction
      "super + {_,shift + }{1-9,0}" = "bspc {desktop -f,node -d} '^{1-9,10}'"; # focus or send to the given desktop
    };
  };
}
