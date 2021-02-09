{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    shellInit = ''
      export EDITOR='vim'
      export GIT_EDITOR='vim'
    '';
    ohMyZsh = {
      enable = true;
      theme = "agnoster";
      plugins = [ "git" ];
    };
  };
}
