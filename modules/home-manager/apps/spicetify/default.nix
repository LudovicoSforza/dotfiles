{ pkgs
, unstable
, lib
, inputs
, ...
}: {
  # allow spotify to be installed if you don't have unfree enabled already
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "spotify-unwrapped"
    ];

  # configure spicetify :)
  programs.spicetify =
    let
      spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
    in
    {
      enable = true;
      theme = spicePkgs.themes.catppuccin-mocha;
      # OR
      # theme = spicetify-nix.pkgSets.${pkgs.system}.themes.catppuccin-mocha;
      colorScheme = "flamingo";

      enabledExtensions = with spicePkgs.extensions; [
        fullAppDisplay
        shuffle
        hidePodcasts
        adblock
      ];

      # enabledCustomApps = ["marketplace"];
    };
}
