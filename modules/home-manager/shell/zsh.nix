{pkgs, ...}: {
  home.packages = with pkgs; [commitizen exa fzf fd bat ripgrep lazygit];
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    defaultKeymap = "emacs";
    dirHashes = {
      config = "$HOME/.config/nixos";
      dl = "$HOME/Downloads";
      gdl = "$HOME/gallery-dl";
    };
    dotDir = ".config/zsh";
    history = {
      ignorePatterns = ["rm *" "pkill *"];
    };
    initExtraFirst = ''
      eval "$(starship init zsh)"
    '';
    initExtra = ''
      ## case insensitive path-completion
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
      zstyle ':completion:*' menu select
    '';
    shellAliases = {
      "bs" = "doas nixos-rebuild switch --flake ~/.config/nixos";
      "bb" = "doas nixos-rebuild boot --flake ~/.config/nixos";
      "config" = "cd ~/.config/nixos";
      "hs" = "home-manager switch --flake ~/.config/nixos";
      "hx" = "helix";
      "lg" = "lazygit";
      "ls" = "exa --icons";
      "l" = "exa -lbF --git --icons";
      "ll" = "exa -lbGF --git --icons";
      "llm" = "exa -lbGF --git --sort=modified --icons";
      "la" = "exa -lbhHigUmuSa --time-style=long-iso --git --color-scale --icons";
      "lx" = "exa -lbhHigUmuSa@ --time-style=long-iso --git --color-scale --icons";
      "nv" = "nvim";
      "g" = "git";
      "gcl" = "git clone";
      "gcm" = "cz c";
      "gpl" = "git pull";
      "gpsh" = "git push -u origin";
      "sudo" = "doas";
      "..." = "cd ../..";
      ".." = "cd ..";
    };
    plugins = [
      {
        name = "z";
        src = pkgs.fetchFromGitHub {
          owner = "jethrokuan";
          repo = "z";
          rev = "85f863f20f24faf675827fb00f3a4e15c7838d76";
          sha256 = "1kaa0k9d535jnvy8vnyxd869jgs0ky6yg55ac1mxcxm8n0rh2mgq";
        };
      }
      {
        name = "fzf";
        src = pkgs.fetchFromGitHub {
          owner = "PatrickF1";
          repo = "fzf.fish";
          rev = "096dc8fff16cfbf54333fb7a9910758e818e239d";
          sha256 = "183z8f7y8629nc78bc3gm5xgwyn813qvjrws4bx8vda2jchxzlb5";
        };
      }
    ];
  };
}
