{ config, pkgs, lib, ... }:

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

  home-manager.users = mkMerge [ { root = myGitConfig; } (mapAttrs (_: _: myGitConfig) (import ../definitions/users.nix pkgs)) ];
}
