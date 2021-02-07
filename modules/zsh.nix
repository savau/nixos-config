{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    #interactiveShellInit = ''
    #  export ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh
    #
    #  ZSH_THEME="agnoster"
    #  plugins=(git)

    #  source $ZSH/oh-my-zsh.sh
    #'';
    #promptInit = "";  # avoid conflicts with oh-my-zsh
  };

  environment.systemPackages = with pkgs; [
    oh-my-zsh
    powerline
  ];
}
