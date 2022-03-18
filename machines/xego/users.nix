let
  exampleUser = {
    # account UID override
    # optional, default: next free UID
    uid = 1000;

    # display name
    # optional, default: <username>
    displayName = "Example User";

    # user type to determine isNormalUser and isSystemUser
    # options: "normal" for humans, "system" for system users
    # optional, default: "normal"
    type = "normal";

    # default shell
    # optional, default: <system-shell>
    shell = ./system-shell.nix;

    # user permissions
    # optional, default: {}
    permissions = {
      # should this user be granted all available permissions?
      # optional, default: false
      all = false;

      # additional user permissions by group name
      # for a list of possible options, refer to /modules/users.nix
      # optional, default: []
      groups = [];

      # user permissions by group name to be excluded
      # the user will not be added to groups in this list; overrides permissions.all, permissions.groups and basic groups for normal users
      # optional, default: []
      exclude = [];
    };

    # user-specific git configuration options
    git = {
      userName  = "Example User";
      userEmail = "example-user@example.com";
      extraConfig = {
        pull.rebase       = false;
        submodule.recurse = true;
      };
    };

    # user-specific additional (stateful) data cloned from git repositories
    # source: https://github.com/shanesveller/nix-dotfiles-public-snapshot/blob/55acba39b60272546382834a64ad7992bed1b795/host-skadi/config/nixpkgs/host.nix#L48
    data = {
      someRepo = {
        branch = "main";
        source = "https://github.com/example-user/some-repo.git";
        target = "/home/example-user/some-target";
      };
    };
  };

  pkgs = import <nixpkgs> {};
in
{
  savau = {
    uid = 1000;
    displayName = "Sarah Vaupel";
    permissions.all = true;

    git = {
      userName  = "Sarah Vaupel";
      userEmail = "sarah.vaupel@protonmail.com";
    };

    data = {
      xmonad = {
        branch = "master";
        source = "https://github.com/savau/xmonad-config.git";
        target = "/home/savau/.xmonad";
      };
    };
  };

  # for debugging purposes:
  # anneo = {
  #   uid = 1042;
  #   displayName = "Anne Onymous";
  #   shell = null;
  #   permissions = {
  #     groups = [
  #       "systemd-journal"
  #     ];
  #     exclude = [
  #       "lp" "scanner"
  #     ];
  #   };
  #   git = {
  #     userName  = "Anne Onymous";
  #     userEmail = "anne-onymous@example.com";
  #   };
  # };
  # mlem = {
  #   displayName = "Mike Lembo";
  #   shell = pkgs.bash;
  #   permissions.groups = [
  #     "vboxusers"
  #     "libvirtd"
  #     "docker"
  #   ];
  # };
  # pleb = {
  #   displayName = "Unworthy Pleb";
  # };
}
