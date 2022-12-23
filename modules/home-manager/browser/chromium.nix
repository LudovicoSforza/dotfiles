{pkgs, ...}: {
  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;
    extensions = [
      {
        id = "ilcacnomdmddpohoakmgcboiehclpkmj";
        updateUrl = "https://raw.githubusercontent.com/FastForwardTeam/releases/main/update/update.xml";
      }
      {
        id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; # Ublock Origin
      }
      {
        id = "nngceckbapebfimnlniiiahkandclblb"; # bitwarden - password manager
      }
    ];
  };
}
