{
  lib,
  config,
  pkgs,
  ...
}: let
  catppuccin-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "catppuccin-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "nvim";
      rev = "72540852ca00d7842ea1123635aecb9353192f0b";
      sha256 = "0mb3qhg5aaxvkc8h95sbwg5nm89w719l9apymc5rpmis4r0mr5zg";
    };
  };
in {
  home.packages = with pkgs; [
  ];

  programs.neovim = {
    enable = true;
    withNodeJs = true;
    vimAlias = true;
    viAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      catppuccin-nvim
      vim-nix
      plenary-nvim
      dashboard-nvim
      copilot-vim
      lualine-nvim
      nvim-tree-lua
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      cmp-vsnip
      vim-vsnip
      nvim-cmp
      nvim-lspconfig
      bufferline-nvim
      nvim-colorizer-lua
      impatient-nvim
      telescope-nvim
      indent-blankline-nvim
      nvim-treesitter
      presence-nvim
      comment-nvim
      vim-fugitive
      nvim-web-devicons
    ];

    extraPackages = with pkgs; [
      rnix-lsp
      nixfmt # Nix
      nixpkgs-fmt
      sumneko-lua-language-server
      stylua # Lua
      rust-analyzer
      gcc
      ripgrep
      fd
    ];

    # https://github.com/fufexan/dotfiles/blob/main/home/editors/neovim/default.nix#L41
    extraConfig = let
      luaRequire = module:
        builtins.readFile (builtins.toString
          ./lua
          + "/${module}.lua");
      luaConfig = builtins.concatStringsSep "\n" (map luaRequire [
        "cmp"
        "colorizer"
        "keybind"
        "settings"
        "theme"
        "ui"
      ]);
    in ''
      lua << EOF
      ${luaConfig}
      EOF
    '';
  };
  # home.file.".config/nvim/settings.lua".source = ./init.lua;
  # extraConfig = ''
  #   luafile ~/.config/nvim/settings.lua
  # '';
}
