args'@{ pkgs, lib, machine, ... }:

with lib;

let
  args = args' // {
    vimConfigDir = ../../../dotfiles/vim;
  };

  myVimPrograms.programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      airline    # fancy bottom status line
    # ale        # asynchronous lint engine
      coc-nvim   # conquer of completion language server
      coc-git    # git integration for coc
      fugitive   # allows git operations within vim (via `:Git <command>`)
      vim-nix    # Nix language support
    ];
    extraConfig = builtins.readFile "${args.vimConfigDir}/.vimrc";
  };
in
{
  imports = [
    (import ./coc args)
  ];

  home-manager.users = (mapAttrs (_: _: myVimPrograms) machine.users) // { root = myVimPrograms; };
}
