{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # rnix-lsp
    nixpkgs-fmt
    coreutils
    nodejs-16_x # for copilot
  ];

  # add emacs-overlay
  # nixpkgs.overlays = [
  #   (import (builtins.fetchTarball {
  #     url = "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
  #     sha256 = "1a70ax37k2rqwr4fmk6rad63d0q2r01c8jw9rmvm5hwzvmrjnvjp";
  #   }))
  # ];

  home.file.".doom.d" = {
    # Get Doom Emacs
    source = ./doom.d; # Sets up symlink name ".doom.d" for file "doom.d"
    recursive = true; # Allow symlinking a directory
    onChange = builtins.readFile ./doom.sh; # If an edit is detected, it will run this script.
  };

  programs = {
    emacs = {
      enable = true; # Get Emacs
      # emacsGit, emacsGit-nox, emascPgtk
      package = pkgs.emacs;
    };
  };
}


# FIXME: remove this comment if you want to use nix-doom-emacs version
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
