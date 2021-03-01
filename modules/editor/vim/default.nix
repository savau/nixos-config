{ pkgs, ... }:

let
  rc = builtins.readFile ../../../dotfiles/.vimrc;
  
  # loaded on launch:
  pluginsStart = with pkgs.vimPlugins; [
    supertab   # insert completions via the tab key
    airline    # fancy bottom status line
    fugitive   # allows git operations within vim (via `:Git <command>`)
    gitgutter  # displays a git diff in the sign column
  ];
  
  # manually loadable via `:packadd $plugin-name`:
  pluginsOpt = with pkgs.vimPlugins; [
  ];
in
{
  environment.systemPackages = with pkgs; [
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
