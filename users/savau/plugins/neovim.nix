{ lib, pkgs, home, ... }:

let
  # installs a vim plugin from git with a given tag / branch
  # source: https://breuer.dev/blog/nixos-home-manager-neovim
  pluginGit = ref: repo: pkgs.vimUtils.buildVimPlugin {
    pname = "${lib.strings.sanitizeDerivationName repo}";
    version = ref;
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
      ref = ref;
    };
  };
  # always installs latest version
  plugin = pluginGit "HEAD";
in
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

      (plugin "woelke/vim-nerdtree_plugin_open")
      # {
      #   plugin = null;
      #   type = "lua";
      #   options = ''
      #     let g:nerdtree_plugin_open_cmd = 'xdg-open'
      #   '';
      # }
    ];
    extraConfig = builtins.readFile (builtins.fetchGit {
      url = "https://github.com/savau/vim-config.git";
      ref = "main";
      rev = "c117a59ab4ba75f4720e377bc8acace876c59e41";
    } + "/.vimrc");
  };
}
