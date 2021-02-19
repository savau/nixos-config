{ config, pkgs, ... }:

let
  myGitGlobalConfig = {
    enable = true;
    ignores = [
      "*~"
      "*.swp"
    ];

    userName = "Sarah Vaupel";

    extraConfig = {
      pull = { rebase = false; };
    };
  };
in
{
  home-manager.users = {
    root = {
      programs.git = myGitGlobalConfig;
    };

    savau = {
      programs.git = myGitGlobalConfig;
    };
  };
}
