{ pkgs, inputs, ... }:
{
  home.packages = with inputs.nix-gaming.packages.${pkgs.system};
    [
      roblox-player
    ]
    ++ (with pkgs; [
      # gamescope #TODO: add it when wlroots error is fixed
      gamemode
      steam
    ]);
}
