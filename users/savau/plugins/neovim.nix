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
      vim-gitgutter
      vim-nix
      vimtex
      YouCompleteMe
    ];
    extraConfig = builtins.readFile (builtins.fetchGit {
      url = "https://github.com/savau/vim-config.git";
      ref = "main";
      rev = "5857a5546bc78cd6b59fd573d1a07097220a160b";
    } + "/.vimrc");
  };
}
