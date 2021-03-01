args@{ pkgs, ... }:

let
  rc = builtins.readFile ../../../dotfiles/.vimrc;
  
  # loaded on launch:
  pluginsStart = with pkgs.vimPlugins; [
    airline    # fancy bottom status line
    #ale       # asynchronous lint engine
    coc-nvim   # conquer of completion language server
    coc-git    # git integration for coc
    fugitive   # allows git operations within vim (via `:Git <command>`)
    vim-nix    # Nix language support
  ];
  
  # manually loadable via `:packadd $plugin-name`:
  pluginsOpt = with pkgs.vimPlugins; [
  ];
in
{
  imports = [
    (import ./haskell-language-server.nix args)
  ];

  environment.systemPackages = with pkgs; [
    nodejs  # coc requirement

    (vim_configurable.customize {
      name = "vim";
      vimrcConfig = {
        customRC = rc;
        packages.myVimPackage = {
          start = pluginsStart;
          opt = pluginsOpt;
        };
      };
    })
    (neovim.override {
      viAlias = true;
      vimAlias = true;
      configure = {
        customRC = rc;
        packages.myPlugins = {
          start = pluginsStart;
          opt = pluginsOpt;
        };
      };
    })
  ];
}
