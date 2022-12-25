{ config
, inputs
, pkgs
, ...
}:
let
  catppuccin-mocha = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "grub";
    rev = "81e68949ffca426302c2e0387d861505b9ad8ce2";
    sha256 = "sha256-op6Hu6qpErezhcSzI3D/lOTK+YMXrfvSVZKWx3VHMtk=";
  };
  theme = "${catppuccin-mocha}/src/catppuccin-mocha-grub-theme";
in
{
  boot = {
    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback # Virtual Camera for OBS-Studio
    ];
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    supportedFilesystems = [ "ntfs" ];
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      # systemd-boot.enable = true;
      grub = {
        enable = true;
        efiSupport = true;
        version = 2;
        device = "nodev";
        useOSProber = true;
        theme = "${theme}";
      };
    };
    kernel.sysctl = {
      "vm.swappiness" = 10;
    };
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";

    colors =
      let
        colorscheme = inputs.nix-colors.colorSchemes.catppuccin;
      in
      with colorscheme.colors; [
        base01
        base08
        base0B
        base0A
        base0D
        base0E
        base0C
        base06
        base02
        base08
        base0B
        base0A
        base0D
        base0E
        base0C
        base07
      ];
  };
}
