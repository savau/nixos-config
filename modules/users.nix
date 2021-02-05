{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
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
}
