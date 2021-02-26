{ config, pkgs, lib, machine, ... }:

with lib;

let
  myGitConfig = {
    programs.git = {
      enable = true;

      ignores = [
        "*~"
        "*.swp"  # vi swap files
      ];

      extraConfig = {
        pull = { rebase = false; };
      };
    };
  };
in
{
  environment.systemPackages = with pkgs; [
    git
  ];

  home-manager.users = (mapAttrs (_: _: myGitConfig) machine.users) // { root = myGitConfig; };
}
