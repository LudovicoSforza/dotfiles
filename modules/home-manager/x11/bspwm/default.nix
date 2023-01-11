{ config, lib, pkgs, ... }:

{
  imports = [
    ../../apps/sxhkd
    ../../apps/picom
    ../../apps/i3status
  ];
  xsession = {
    enable = true;
    scriptPath = ".xsession-bspwm";
    windowManager.bspwm = {
      enable = true;
      monitors = { eDP-1 = [ "1" "2" "3" "4" "5" ]; };
      rules = {
        "Firefox" = { desktop = "^2"; };
        "Discord" = { desktop = "^3"; };
      };
      settings = {
        border_width = 2;
        gapless_monocle = true;
        split_ratio = 0.52;
      };
      startupPrograms = [
        "picom"
        "i3status-rs"
        "pgrep -x sxhkd > /dev/null || sxhkd"
        "feh --bg-fill ~/Pictures/Wallpaper/main.png"
      ];
    };
  };
}
