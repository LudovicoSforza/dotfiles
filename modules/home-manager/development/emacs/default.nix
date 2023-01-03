{ pkgs, ... }:

{
  home.packages = with pkgs; [
    rnix-lsp
    nixpkgs-fmt
    coreutils
  ];

  home.file.".doom.d" = {
    # Get Doom Emacs
    source = ./doom.d; # Sets up symlink name ".doom.d" for file "doom.d"
    recursive = true; # Allow symlinking a directory
    onChange = builtins.readFile ./doom.sh; # If an edit is detected, it will run this script.
  };

  programs = {
    emacs.enable = true; # Get Emacs
  };
}


## Use code below if you want to use nix-doom-emacs
## I personally don't like it, because of some performance issue
# { pkgs
# , lib
# , sources
# , ...
# }: {

#   programs.doom-emacs = {
#     enable = true;
#     doomPrivateDir = ./doom.d;
#   };

#   services.emacs = {
#     enable = true;
#     defaultEditor = true; # it will override $EDITOR
#   }
#}
