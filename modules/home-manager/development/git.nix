{ pkgs, ... }: {
  programs.git = {
    userEmail = "ludovicopiero@pm.me";
    userName = "Ludovico Piero";
    diff-so-fancy.enable = true;
    signing = {
      key = "E4EF0932B0ACD6FB";
      signByDefault = true;
    };
    extraConfig = {
      init = { defaultBranch = "main"; };
      core = { excludesfile = "$NIXOS_CONFIG_DIR/scripts/gitignore"; };
      credential.helper = "${
        pkgs.git.override {withLibsecret = true;}
      }/bin/git-credential-libsecret";
    };
  };
}
