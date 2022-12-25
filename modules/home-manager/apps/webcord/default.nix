{ pkgs
, lib
, inputs
, ...
}:
let
  catppuccin = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "discord";
    rev = "714c2a2726012e806d93d5f9d978396fdf89f6b0";
    sha256 = "sha256-cWpog52Ft4hqGh8sMWhiLUQp/XXipOPnSTG6LwUAGGA=";
  };
  CatpuccinMocha = "${catppuccin}/themes/mocha.theme.css";
in
{
  imports = [
    inputs.webcord.homeManagerModules.default
  ];

  programs.webcord = {
    enable = true;
    # themes = "${CatpuccinMocha}";
  };
}
