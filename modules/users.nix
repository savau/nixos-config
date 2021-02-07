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

  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = true;

  users.users.savau = {
    description = "Sarah Vaupel";
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "audio" "video"
      "systemd-journal"
      "networkmanager"
      "vboxusers"
      "libvirtd"
      "docker"
    ];
    shell = pkgs.zsh;
    uid = 1000;
    #openssh.authorizedKeys.keyFiles = [ ../keys/github.pub ];
  };

  environment.systemPackages = with pkgs; [
    oh-my-zsh
    powerline
  ];
}
