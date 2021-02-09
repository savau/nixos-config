{ config, pkgs, ... }:

{
  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = true;

  users = {
    extraUsers.root.shell = pkgs.zsh;
    
    users.savau = {
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
    };
  };
}
