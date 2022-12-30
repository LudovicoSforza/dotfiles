{ pkgs
, lib
, sources
, ...
}: {
  home.packages = with pkgs; [
    rnix-lsp
    nixpkgs-fmt
  ];

  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = ./doom.d;
  };

  services.emacs = {
    enable = true;
    defaultEditor = true; # it will override $EDITOR
  };
}
