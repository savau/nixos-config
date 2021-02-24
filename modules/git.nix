{ config, pkgs, ... }:

let
  myGitConfig = {
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
  environment.systemPackages = with pkgs; [
    git
  ];

  home-manager.users = {
    root.programs.git = myGitConfig;
    savau.programs.git = myGitConfig;
  };
}
