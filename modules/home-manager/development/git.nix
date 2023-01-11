{ pkgs, ... }: {
  programs.git = {
    userEmail = "ludovicopiero@pm.me";
    userName = "Ludovico Piero";
    diff-so-fancy.enable = true;
    signing = {
      key = "0x3A80AFACABE6DA16";
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
