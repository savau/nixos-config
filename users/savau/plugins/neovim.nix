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
    withPython3 = true;
    plugins = with pkgs.vimPlugins; [
      airline
      fugitive
      nerdtree
      nerdtree-git-plugin
      nvim-treesitter  # required for telescope
      plenary-nvim  # required for telescope
      telescope-nvim
      telescope_hoogle
      vim-gitgutter
      vim-nix
      vimtex
      YouCompleteMe
    ];
    extraConfig = builtins.readFile (builtins.fetchGit {
      url = "https://github.com/savau/vim-config.git";
      ref = "main";
      rev = "3e8ff0ac3abdce9e35f63bffc89ae9b0b218755d";
    } + "/.vimrc");
  };
}
