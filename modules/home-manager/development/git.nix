{ pkgs, ... }: {
  programs.git = {
    userEmail = "ludovicopiero@pm.me";
    userName = "Ludovico Piero";
    diff-so-fancy.enable = true;
    signing = {
      key = "267C8AC8AB72BD95";
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
