{ config, pkgs, lib, machine, ... }:

let
# TODO: securely fetch home-manager (pick rev and ref)
#  home-manager = builtins.fetchGit {
#    url = "https://github.com/rycee/home-manager.git";
#    rev = "55030c83024bf2d10ff86f3874b91794b9d32722";
#    ref = "master";
#  };
  stateVersion = { home.stateVersion = "22.11"; };
in
{
  imports = [
    #(import "${home-manager}/nixos")
    (import "${builtins.fetchTarball https://github.com/rycee/home-manager/archive/master.tar.gz}/nixos")
  ];

  system.stateVersion = "22.11";
  home-manager.users = (lib.mapAttrs (_: _: stateVersion) machine.users) // { root = stateVersion; };
}
