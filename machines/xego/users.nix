# Full user specification:
#   <username> = {
#     # account UID override
#     # optional, defaults to next free UID
#     id = 1000;
# 
#     # display name
#     # optional, defaults to <username>
#     displayName = "Default User";
# 
#     # user type to determine isNormalUser and isSystemUser
#     # options: "normal" for humans, "system" for system users
#     # optional, default: "normal"
#     type = "normal";
# 
#     # should this user be a super user?
#     isSuperUser = false;
# 
#     # user permissions
#     permissions = {
#       # should this user be granted all permissions available on this machine?
#       all = false;  # TODO: replace with separate wheel flag
# 
#       # additional user permissions by group name
#       # for a list of possible options, refer to /modules/users.nix
#       additional = [];
#     };
# 
#     # default shell
#     shell = ./system-shell.nix;
#   };
#
# Refactor user logic:
# TODO: add global git config
# TODO: add local-ish git config? (i.e. for u2w)
# TODO: replace permissions.all with separate wheel/superuser flag
# TODO: rename id -> uid
# TODO: implement user group blacklist (i.e. to exclude a user from specific user groups)
# TODO: replace additional permissions list with separate flags

let
  pkgs = import <nixpkgs> {};
in
{
  savau = {
    id = 1000;
    displayName = "Sarah Vaupel";
    permissions.all = true;
  };

  # for debugging purposes:
  #anneo = {
  #  id = 1042;
  #  displayName = "Anne Onymous";
  #  shell = null;
  #  permissions.additional = [
  #    "systemd-journal"
  #  ];
  #};
  #mlem = {
  #  id = 1043;
  #  displayName = "Mike Lembo";
  #  shell = pkgs.bash;
  #  permissions.additional = [
  #    "vboxusers"
  #    "libvirtd"
  #    "docker"
  #  ];
  #};
  #pleb = {
  #  id = 1044;
  #  displayName = "Unworthy Pleb";
  #};
}
