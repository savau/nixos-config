{ lib, pkgs, home, ... }:

{
  home.sessionVariables = {
    GIT_EDITOR = "vim";
  };

  home.packages = with pkgs; [
    fd ripgrep  # required for telescope
  ];

  # TODO: configure coc (see vim-config repo)
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true; vimAlias = true; vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      airline
      fugitive
      nerdtree
      nerdtree-git-plugin
      nvim-treesitter  # required for telescope
      plenary-nvim  # required for telescope
      telescope-nvim
      vim-bbye
      vim-gitgutter
      vim-nix
      vimtex
      YouCompleteMe
    ];
    extraConfig = builtins.readFile (builtins.fetchGit {
      url = "https://github.com/savau/vim-config.git";
      ref = "main";
      rev = "e4ed556fa9fff313240b82046a608b2b67e75c6d";
    } + "/.vimrc");
  };
}
