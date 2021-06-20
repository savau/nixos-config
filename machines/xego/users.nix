# Full user specification:
# TODO: move documentation to /modules/users.nix
#   <username> = {
#     # account UID override
#     # optional, default: next free UID
#     uid = 1000;
# 
#     # display name
#     # optional, default: <username>
#     displayName = "Default User";
# 
#     # user type to determine isNormalUser and isSystemUser
#     # options: "normal" for humans, "system" for system users
#     # optional, default: "normal"
#     type = "normal";
# 
#     # user permissions
#     permissions = {
#       # should this user be granted all available permissions?
#       # optional, default: false
#       all = false;
# 
#       # additional user permissions by group name
#       # for a list of possible options, refer to /modules/users.nix
#       groups = [];
#
#       # user permissions by group name to be excluded
#       # the user will not be added to groups in this list; overrides permissions.all, permissions.groups and basic groups for normal users
#       exclude = [];
#     };
# 
#     # default shell
#     shell = ./system-shell.nix;
#   };
#
# Refactor user logic:
# TODO: add global git config
# TODO: add local-ish git config? (i.e. for u2w)

let
  pkgs = import <nixpkgs> {};
in
{
  savau = {
    uid = 1000;
    displayName = "Sarah Vaupel";
    permissions.all = true;
  };

  # for debugging purposes:
  # anneo = {
  #   uid = 1042;
  #   displayName = "Anne Onymous";
  #   shell = null;
  #   permissions.groups = [
  #     "systemd-journal"
  #   ];
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
