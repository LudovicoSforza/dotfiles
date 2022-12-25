{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: {
  home.packages = with pkgs; [
    hyprpaper # For Wallpaper
    bemenu # Menu
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast

    # Utils
    brightnessctl
    grim
    jq
    playerctl
    slurp

    swaylock
    viewnior
    wl-clipboard
    xdg-user-dirs
    xdg-utils
    yad
  ];

  imports = [
    # ../apps/mako
    ../../apps/waybar
    ../../apps/gammastep
    # ../../apps/eww
    ./config.nix
  ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
  };

  # https://github.com/fufexan/dotfiles/blob/main/home/wayland/hyprland/default.nix#L36
  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.swaylock-effects}/bin/swaylock -fF -c 000000";
      }
      {
        event = "lock";
        command = "${pkgs.swaylock-effects}/bin/swaylock -fF -c 000000";
      }
    ];
    timeouts = [
      {
        timeout = 600;
        command = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl dispatch dpms off";
        resumeCommand = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl dispatch dpms on";
      }
      {
        timeout = 610;
        command = "${pkgs.systemd}/bin/loginctl lock-session";
      }
    ];
  };

  # start swayidle as part of hyprland, not sway
  systemd.user.services.swayidle.Install.WantedBy = lib.mkForce ["hyprland-session.target"];

  wayland.windowManager.hyprland = {
    enable = true;
  };

  xdg.configFile = {
    "hypr/Wallpaper" = {
      source = ./Wallpaper;
    };
    "hypr/scripts" = {
      source = ./scripts;
    };
    "hypr/hyprpaper.conf" = {
      text = ''
        preload = /home/ludovico/.config/hypr/Wallpaper/Wallpaper3.jpg
        wallpaper = eDP-1,/home/ludovico/.config/hypr/Wallpaper/Wallpaper3.jpg
        ipc = off
      '';
    };
  };
}
