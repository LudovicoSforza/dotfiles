{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    # enableFishIntegration = true;
  };
  services.lorri = {
    enable = true;
    enableNotifications = true;
  };
}
