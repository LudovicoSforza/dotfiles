{ pkgs
, inputs
, ...
}: {
  # Remove sound.enable or turn it off if you had it set previously, it seems to cause conflicts with pipewire
  sound.enable = false;
  hardware = {
    pulseaudio.enable = false;
    bluetooth.enable = true;
  };
  environment.pathsToLink = [ "/share/zsh" ];

  xdg.portal = {
    enable = true;
    wlr.enable = false;
    # extraPortals = [
    #   inputs.xdph.packages.${pkgs.system}.default
    # ];
  };

  environment = {
    etc = {
      "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
        bluez_monitor.properties = {
        	["bluez5.enable-sbc-xq"] = true,
        	["bluez5.enable-msbc"] = true,
        	["bluez5.enable-hw-volume"] = true,
        	["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
        }
      '';
    };
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      _JAVA_AWT_WM_NONREPARENTING = "1";
      NIXOS_CONFIG_DIR = "$HOME/.config/nixos";
    };
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
    pam.services.swaylock.text = "auth include login";
  };

  programs = {
    # make HM-managed GTK stuff work
    dconf.enable = true;

    # Enable Hyprland and the options
    hyprland.enable = true;
  };

  # Use Gnome Theme for QT
  qt5.platformTheme = "gnome";

  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      amdvlk
      rocm-opencl-icd
    ];
    driSupport = true;
    driSupport32Bit = true; # For wine, etc.
  };

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wants = [ "graphical-session.target" ];
      wantedBy = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  services = {
    # needed for GNOME services outside of GNOME Desktop
    dbus.packages = [ pkgs.gcr ];
    udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

    # TLP For Laptop
    tlp.enable = true;
    tlp.settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      # https://linrunner.de/en/tlp/docs/tlp-faq.html#battery
      # use "tlp fullcharge" to override temporarily
      START_CHARGE_THRESH_BAT0 = 85;
      STOP_CHARGE_THRESH_BAT0 = 90;
      START_CHARGE_THRESH_BAT1 = 85;
      STOP_CHARGE_THRESH_BAT1 = 90;
    };

    gnome.gnome-keyring.enable = true; # Keyring daemon

    xserver = {
      enable = true;
      layout = "us"; # Configure keymap
      libinput.enable = true;
      deviceSection = ''
        Option "TearFree" "true"
      '';
      # displayManager.lightdm = {
      #   enable = true;
      #   greeters.gtk = {
      #     theme = {
      #       package = pkgs.arc-theme;
      #       name = "Arc-Dark";
      #     };
      #     iconTheme = {
      #       package = pkgs.papirus-icon-theme;
      #       name = "Papirus-Dark";
      #     };
      #     cursorTheme = {
      #       package = pkgs.capitaine-cursors;
      #       name = "capitaine-cursors-white";
      #       size = 24;
      #     };
      #   };
      # };
      displayManager.sddm = {
        enable = true;
        theme = "multicolor-sddm-theme";
      };

      displayManager.session = [
        {
          manage = "window";
          name = "i3";
          start = ''
            exec $HOME/.xsession-i3
          '';
        }
      ];
    };

    # add hyprland to display manager sessions
    xserver.displayManager.sessionPackages = [
      inputs.hyprland.packages.${pkgs.system}.default
    ];

    # Pipewire
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
      config.pipewire-pulse = {
        "context.exec" = [
          {
            path = "pactl";
            args = "load-module module-switch-on-connect";
          }
        ];
      };
    };
  };
}
