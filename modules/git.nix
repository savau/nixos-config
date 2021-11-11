{ config, pkgs, lib, machine, ... }:

let
# system-wide default configuration
# can be overriden per user via machine.users.<username>.git
  gitConfig = {
    programs.git = {
      enable = true;

      ignores = [
        "*~"
        "*.swp"  # vi swap files
      ];

      extraConfig = {
        pull.rebase           = false;
        submodule.recurse     = true;
        advice.addIgnoredFile = false;
      };
    };
  };
in
{
  home-manager.users = (lib.mapAttrs (_: user: if user?git then { programs.git = gitConfig.programs.git // user.git; } else gitConfig) machine.users) // { root = gitConfig; };
}
