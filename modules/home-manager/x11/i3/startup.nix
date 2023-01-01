{ pkgs
, lib
, ...
}: [
  {
    command = "${pkgs.feh}/bin/feh --bg-fill $HOME/Pictures/tdark.png";
    notification = false;
  }
  {
    command = "${pkgs.picom}/bin/picom";
    notification = false;
  }
  {
    command = "${pkgs.dunst}/bin/dunst";
    notification = false;
  }
  {
    command = "xset r rate 300 30";
    notification = false;
  }
]
