{ pkgs
, lib
, inputs
, config
, ...
} @ args: {
  home.packages = with pkgs; [
    alsa-utils
  ];
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        position = "top";
        monitor = "eDP-1";
        layer = "top";
        height = 30;

        modules-left = [ "wlr/workspaces" "tray" ];
        modules-right = [
          #   "wlr/workspaces"
          #   "tray"
          "network"
          "wireplumber"
          # "custom/weather"
          "battery"
          "custom/date"
          "clock"
        ];
        "wireplumber" = {
          "format" = "{icon} {volume}%";
          "format-muted" = "";
          "on-click" = "amixer -q set Master toggle-mute";
          "format-icons" = [ "" "" "" ];
        };
        "wlr/workspaces" = {
          on-click = "activate";
          active-only = false;
          disable-scroll = true;
          all-outputs = true;
          format = "{icon}";
          format-icons = {
            "1" = "DEV";
            "2" = "WWW";
            "3" = "CHAT";
            "4" = "MUSIC";
            "5" = "MISC";
            # "6" = "6";
            # "7" = "7";
            # "8" = "8";
            # "9" = "9";
            # "10" = "10";
            # "active" = "";
            "default" = "";
          };
        };
        "tray" = {
          spacing = 5;
        };
        "network" = {
          interface = "wlp3s0";
          format-wifi = "  Connected";
          format-linked = "{ifname} (No IP)";
          format-disconnected = "  Disconnected";
          tooltip-format-wifi = "Signal Strenght: {signalStrength}% | Down Speed: {bandwidthDownBits}, Up Speed: {bandwidthUpBits}";
        };
        "custom/weather" = {
          "format" = "{}";
          "format-alt" = "{alt}: {}";
          "format-alt-click" = "click-right";
          "interval" = 1800;
          "return-type" = "json";
          "exec" = "~/.config/hypr/scripts/weather.sh";
          "exec-if" = "ping wttr.in -c1";
        };
        "battery" = {
          bat = "BAT1";
          interval = 60;
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          states = {
            "good" = 95;
            "warning" = 20;
            "critical" = 10;
          };
          format-icons = [
            " "
            " "
            " "
            " "
            " "
          ];
        };
        "custom/date" = {
          format = "  {}";
          interval = 3600;
          exec = pkgs.writeShellScript "waybar-date" ''
            date "+%a %d %b %Y"
          '';
        };
        "clock" = {
          format = " {:%I:%M %p}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };
      };
    };
    style = import ./style.nix args;
  };
}
