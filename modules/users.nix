{ config, pkgs, ... }:

# TODO: securely fetch home-manager (pick rev and ref)
#let
#  home-manager = builtins.fetchGit {
#    url = "https://github.com/rycee/home-manager.git";
#    rev = "55030c83024bf2d10ff86f3874b91794b9d32722";
#    ref = "master";
#  };
#in
{
  #imports = [
  #  #(import "${home-manager}/nixos")
  #  (import "${builtins.fetchTarball https://github.com/rycee/home-manager/archive/master.tar.gz}/nixos")
  #];

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
