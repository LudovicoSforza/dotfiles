{ pkgs, ... }: {
  home.packages = with pkgs; [ commitizen exa fzf fd bat ripgrep lazygit ];
  programs.nix-index.enable = true;
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
      size = 5000;
      ignorePatterns = [ "rm *" "pkill *" ];
    };
    initExtraFirst = ''
      eval "$(starship init zsh)"
    '';
    initExtra = ''
            ## case insensitive path-completion
            zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
            zstyle ':completion:*' menu select

      function run() {
                    nix run nixpkgs#$@
      }
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
    sessionVariables = {
      LC_ALL = "en_US.UTF-8";
      ZSH_AUTOSUGGEST_USE_ASYNC = "true";
      SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
    };
    plugins = with pkgs; [
      {
        name = "zsh-nix-shell";
        src = zsh-nix-shell;
        file = "share/zsh-nix-shell/nix-shell.plugin.zsh";
      }
      {
        name = "z";
        src = zsh-z;
        file = "share/zsh-z/zsh-z.plugin.zsh";
      }
      {
        name = "zsh-history-substring-search";
        file = "zsh-history-substring-search.plugin.zsh";
        src = fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-history-substring-search";
          rev = "0f80b8eb3368b46e5e573c1d91ae69eb095db3fb";
          sha256 = "0y8va5kc2ram38hbk2cibkk64ffrabfv1sh4xm7pjspsba9n5p1y";
        };
      }
    ];
  };
}
