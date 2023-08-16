{ lib, pkgs, home, ... }:

{
  home.sessionVariables = {
    GIT_EDITOR = "vim";
  };

  # TODO: configure coc (see vim-config repo)
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true; vimAlias = true; vimdiffAlias = true;
    withPython3 = true;
    plugins = with pkgs.vimPlugins; [
      airline
      fugitive
      plenary-nvim # required for telescope
      telescope-hoogle
      telescope-nvim
      vim-gitgutter
      vim-nix
      vimtex
    ];
    extraConfig = builtins.readFile (builtins.fetchGit {
      url = "https://github.com/savau/vim-config.git";
      ref = "main";
    } + "/.vimrc");
  };
}
