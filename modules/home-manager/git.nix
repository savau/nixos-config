{ config, pkgs, ... }:

let
  myGlobalGitConfig = {
    enable = true;

    ignores = [
      "*~"
      "*.swp"  # vi swap files
    ];

    userName = "Sarah Vaupel";
    userEmail = "";

    extraConfig = {
      pull = { rebase = false; };
    };
  };
in
{
  home-manager.users = {
    root = {
      programs = {
        git = myGlobalGitConfig;
      };
    };

    savau = {
      programs = {
        git = myGlobalGitConfig;
      };
    };
  };
}
